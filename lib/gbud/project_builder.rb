# frozen_string_literal: true

# Copyright 2017 Richard Davis
#
# This file is part of gbud.
#
# gbud is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# gbud is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with gbud.  If not, see <http://www.gnu.org/licenses/>.

require 'date'

module GBud
  ##
  # = ProjectBuilder
  # Author::    Richard Davis
  # Copyright:: Copyright 2017 Richard Davis
  # License::   GNU Public License 3
  #
  # The engine that is instantiated to build out the project directory
  # skeleton and basic files using templates.
  class ProjectBuilder
    # Project metadata information supplied by user
    attr_reader :metadata
    # Option for making project executable
    attr_reader :cli
    # Hash containing file names for project templates
    attr_reader :templates
    # Hash containing file names for project assets
    attr_reader :assets
    # Hash specifying project directories
    attr_reader :paths

    ##
    # Instantiates a ProjectBuilder object
    def initialize(metadata, cli)
      @metadata = metadata
      @cli = cli
      @templates = {
        'readme.md': 'README.md',
        'gemspec.rb': "#{metadata[:name]}.gemspec",
        'gemfile.rb': 'Gemfile',
        'rakefile.rb': 'Rakefile',
        'base.rb': 'base.rb',
        'hello.rb': 'hello.rb',
        'test_hello.rb': 'test_hello.rb',
        'namespace.rb': "#{metadata[:name].to_s.tr('-', '_')}.rb"
      }
      @assets = {
        license: 'LICENSE'
      }
      @paths = {
        project_dir: "#{metadata[:name]}/",
        project_lib_dir: "#{metadata[:name]}/lib/",
        project_lib_project_dir: "#{metadata[:name]}/lib/#{metadata[:name]}/",
        project_test_dir: "#{metadata[:name]}/test/"
      }
      exit unless cli == true
      @templates[:'executable.rb'] = metadata[:name].to_s
      @paths[:project_bin_dir] = "#{metadata[:name]}/bin/"
    end

    ##
    # Builds the project
    def build
      make_directories
      render_templates
      copy_assets
    end

    private

    ##
    # Creates the project directories
    def make_directories
      @paths.each do |_path, dir|
        FileUtils.mkdir_p(dir)
      end
    end

    ##
    # Makes the files using templates
    def render_templates
      @templates.each do |template, filename|
        directory = map_template template
        file = File.new "#{directory}#{filename}", 'w+'
        file.puts(render(template))
        file.close
        make_executable if template == :'executable.rb'
      end
    end

    ##
    # Maps each templated file to correct directory
    def map_template(template)
      case template
      when :'readme.md'
        @paths[:project_dir]
      when :'gemspec.rb'
        @paths[:project_dir]
      when :'gemfile.rb'
        @paths[:project_dir]
      when :'rakefile.rb'
        @paths[:project_dir]
      when :'base.rb'
        @paths[:project_lib_project_dir]
      when :'hello.rb'
        @paths[:project_lib_project_dir]
      when :'executable.rb'
        @paths[:project_bin_dir]
      when :'test_hello.rb'
        @paths[:project_test_dir]
      when :'namespace.rb'
        @paths[:project_lib_dir]
      end
    end

    ##
    # Renders the templates into files
    def render(template)
      path = File.expand_path(File.join(File.dirname(__FILE__),
                                        '..',
                                        'templates',
                                        "#{template}.erb"))
      ERB.new(File.read(path)).result(binding)
    end

    ##
    # Flags the CLI file as executable
    def make_executable
      File.chmod(0o755, "#{@paths[:project_bin_dir]}#{@templates[:'executable.rb']}")
    end

    ##
    # Copies the assets
    def copy_assets
      @assets.each do |asset, filename|
        directory = map_asset asset
        FileUtils.cp(File.expand_path(File.join(File.dirname(__FILE__),
                                                '..',
                                                'assets',
                                                filename.to_s)),
                     "#{directory}#{filename}")
      end
    end

    ##
    # Maps each asset file to correct directory
    def map_asset(asset)
      case asset
      when :gitignore
        @paths[:project_dir]
      when :license
        @paths[:project_dir]
      end
    end
  end
end
