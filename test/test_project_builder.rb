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

require 'minitest/autorun'
require_relative '../lib/gbud/project_builder'

##
# = ProjectBuilderTest
# Author::    Richard Davis
# Copyright:: Copyright 2017 Richard Davis
# License::   GNU Public License 3
#
# Tests for GBud::ProjectBuilder class functionality.
class ProjectBuilderTest < Minitest::Test
  ##
  # Initializes test with sample data
  def setup
    metadata = {
      name: 'gbud-test',
      authors: 'Richard Davis, d3d1rty',
      email: 'rvdavis@member.fsf.org',
      url: 'https://test.com',
      summary: 'This is a test summary.',
      description: 'This is a test description.'
    }
    @builder = GBud::ProjectBuilder.new metadata, false
  end
end
