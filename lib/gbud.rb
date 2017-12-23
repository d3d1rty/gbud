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

##
# = gbud.rb
# Author::    Richard Davis
# Copyright:: Copyright 2017 Richard Davis
# License::   GNU Public License 3
#
# The main script for handling user input and program execution.
require 'fileutils'
require 'optparse'
require 'erb'

require 'gbud/user_prompt'
require 'gbud/project_metadata'
require 'gbud/project_builder'

trap('INT') do
  puts "\nTerminating..."
  exit
end

options = {}

optparse = OptionParser.new do |opts|
  opts.banner = 'Usage: gbud [options]'

  opts.on('-n', '--new NAME', 'Creates a project given a name') do |name|
    options[:name] = name
  end

  opts.on('--cli', 'Creates an executable with option parsing') do
    options[:cli] = true
  end

  opts.on('--no-cli', 'Creates an executable without option parsing') do
    options[:cli] = false
  end

  opts.on('-l', '--license', 'Displays the copyright notice') do
    puts "This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.
"
  end

  opts.on('-w', '--warranty', 'Displays the warranty statement') do
    puts "This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.
"
  end

  opts.on_tail('-h', '--help', 'Displays the help screen') do
    puts opts
    exit
  end
end

optparse.parse!

if options[:name]
  metadata = GBud::ProjectMetadata.new
  metadata.name = options[:name]
  if metadata.name.nil?
    puts 'Invalid gem name. See RubyGems for gem naming conventions.'
    exit 1
  end
  metadata.authors = GBud::UserPrompt.get_value 'Project authors => '
  loop do
    metadata.email = GBud::UserPrompt.get_value 'Project email => '
    break unless metadata.email.nil?
    puts 'Please enter a valid email address.'
  end
  loop do
    metadata.url = GBud::UserPrompt.get_value 'Project website => '
    break unless metadata.url.nil?
    puts 'Please enter a valid project URL'
  end
  metadata.summary = GBud::UserPrompt.get_value 'Enter a short summary of the project => '
  metadata.description = GBud::UserPrompt.get_value 'Enter a description of the project => '
  options[:cli] = true if options[:cli].nil?
  project = GBud::ProjectBuilder.new metadata.to_hash, options[:cli]
  project.build
end

