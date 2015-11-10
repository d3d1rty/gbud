# gbud base script
# Copyright 2015 Richard Davis GPL v3
require 'fileutils'
require './lib/gbud/getinfo.rb'

p_name = GetInfo.user_prompt('Project name => ')
version = GetInfo.user_prompt('Version number => ')
authors = GetInfo.user_prompt('Authors separated by a comma => ').split(', ')
email = GetInfo.user_prompt('Project email => ')
site = GetInfo.user_prompt('Project website => ')
summary = GetInfo.user_prompt('Enter a short summary of the project => ')
description = GetInfo.user_prompt('Enter a description of the project => ')
license = GetInfo.user_prompt('Project\'s license => ')

# sets up directory structure
FileUtils.mkdir_p([
  "#{p_name}/bin/",
  "#{p_name}/lib/#{p_name}",
  "#{p_name}/test"
])

# creates lib/base script
FileUtils.touch("#{p_name}/lib/#{p_name}/base.rb")

# creates main script
m = File.new("#{p_name}/lib/#{p_name}.rb", 'w+')
m.puts "require '#{p_name}/base'"
m.close

# creates executable
e = File.new("#{p_name}/bin/#{p_name}", 'w+')
e.puts '#!/usr/bin/env ruby'
e.puts 'begin'
e.puts "\trequire '#{p_name}'"
e.puts 'rescue LoadError'
e.puts "\trequire 'rubygems'"
e.puts "\trequire '#{p_name}'"
e.puts 'end'
e.close
File.chmod(0755, "#{p_name}/bin/#{p_name}")

# writes gemspec
gemspec = File.new("#{p_name}/#{p_name}.gemspec", 'w+')
gemspec.puts '# -*- encoding: utf-8 -*-'
gemspec.puts "lib = File.expand_path('../lib', __FILE__)"
gemspec.puts "$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)\n\n"
gemspec.puts 'Gem::Specification.new do |s|'
gemspec.puts "\ts.name          = \"#{p_name}\""
gemspec.puts "\ts.version       = #{version}"
gemspec.puts "\ts.platform      = Gem::Platform::RUBY"
gemspec.puts "\ts.authors       = #{authors}"
gemspec.puts "\ts.email         = #{email}"
gemspec.puts "\ts.homepage      = #{site}"
gemspec.puts "\ts.summary       = #{summary}"
gemspec.puts "\ts.description   = #{description}"
gemspec.puts "\ts.license       = #{license}"
gemspec.puts "\ts.files         = ['lib/#{p_name}.rb']"
gemspec.puts "\ts.executables   = ['#{p_name}']"
gemspec.puts "\ts.test_files    = ['test/test_#{p_name}.rb']"
gemspec.puts "\ts.require_path  = ['lib']"
gemspec.puts 'end'

# writes Rakefile
r = File.new("#{p_name}/Rakefile")
r.puts 'require \'rake/testtask\''
r.puts 'Rake::TestTask.new do |t|'
r.puts "\tt.libs << 'test'"
r.puts 'end'
r.puts 'desc \'Run tests\''
r.puts 'task :default => :test'
r.close

# TODO: WRITE AUTOMATED TESTS

# runs automated tests
system 'rake'
