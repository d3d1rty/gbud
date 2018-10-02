# frozen_string_literal: true

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
require_relative '../lib/gbud/project_metadata'

##
# = ProjectMetadataTest
# Author::    Richard Davis
# Copyright:: Copyright 2017 Richard Davis
# License::   GNU Public License 3
#
# Tests for GBud::ProjectMetadata class functionality.
class ProjectMetadataTest < Minitest::Test
  ##
  # Initializes test with sample data
  def setup
    @metadata = GBud::ProjectMetadata.new
  end

  ##
  # Tests that an invalid name is not accepted
  def test_name_mutator_negative
    @metadata.name = '-test'
    assert_nil @metadata.name
  end

  ##
  # Tests that a valid name is accepted
  def test_name_mutator_positive
    @metadata.name = 'gbud-test'
    assert_equal 'gbud-test', @metadata.name
  end

  ##
  # Tests that an invalid name is rejected by validate_name
  def test_validate_name_negative
    assert_nil @metadata.validate_name('-fail')
  end

  ##
  # Tests that a valid name is accepted by validate_name
  def test_validate_name_positive
    assert_equal 0, @metadata.validate_name('test-gem')
  end

  ##
  # Tests that an invalid email is rejected by validate_email
  def test_validate_email_negative
    assert_nil @metadata.validate_email('rvdavis')
  end

  ##
  # Tests that a valid email is accepted by validate_email
  def test_validate_email_positive
    assert_equal 0, @metadata.validate_email('rvdavis@member.fsf.org')
  end

  ##
  # Tests that an invalid URL is rejected by validate_url
  def test_validate_url_negative
    assert_nil @metadata.validate_url('github.com')
  end

  ##
  # Tests that a valid URL is accepted by validate_url
  def test_validate_url_positive
    assert_equal 0, @metadata.validate_url('https://github.com/d3d1rty/gbud')
  end

  ##
  # Tests that user-provided author list is split into an array
  def test_authors_mutator
    @metadata.authors = 'Richard Davis, d3d1rty'
    assert_equal ['Richard Davis', 'd3d1rty'], @metadata.authors
  end

  ##
  # Tests that the summary attribute accepts assignment
  def test_summary_mutator
    assert_equal 'This is a test', @metadata.summary = 'This is a test'
  end

  ##
  # Tests that the description attribute accepts assignment
  def test_description_mutator
    assert_equal 'This is a test', @metadata.description = 'This is a test'
  end

  ##
  # Tests that the version attribute is able to be retrieved
  def test_version_accessor
    assert_equal '0.0.1', @metadata.version
  end

  ##
  # Tests that the license attribute is able to be retrieved
  def test_license_accessor
    assert_equal 'GPL-3.0', @metadata.license
  end

  ##
  # Tests that project metadata is properly converted to hash
  def test_to_hash
    @metadata.name = 'gbud-test'
    @metadata.authors = 'Richard Davis, d3d1rty'
    @metadata.email = 'rvdavis@member.fsf.org'
    @metadata.url = 'https://test.com'
    @metadata.summary = 'This is a test summary.'
    @metadata.description = 'This is a test description.'
    assert_instance_of Hash, @metadata.to_hash
  end
end
