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

lib = File.expand_path('../lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.name          = 'gbud'
  s.version       = '0.2.1'
  s.platform      = Gem::Platform::RUBY
  s.authors       = ['Richard Davis']
  s.email         = 'rvdavis@member.fsf.org'
  s.homepage      = 'http://www.github.com/d3d1rty/gbud'
  s.summary       = 'Initializes the basic structure of a gem'
  s.description   = <<~HEREDOC
    This project aims to make starting a new gem project simple by automating
    the creation of all required files and directories for you.
  HEREDOC
  s.license       = 'GPL-3.0'
  s.files         = Dir['lib/**/*']
  s.executables   = ['gbud']
  s.test_files    = Dir['test/**/*']
  s.require_path  = ['lib']
end
