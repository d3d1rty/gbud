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

module GBud
  ##
  # = UserPrompt
  # Author::    Richard Davis
  # Copyright:: Copyright 2017 Richard Davis
  # License::   GNU Public License 3
  #
  # Module containing methods used to prompt the user for program
  # input.
  module UserPrompt
    @value = ''

    ##
    # Returns the value entered by the user
    def self.get_value(prompt)
      prompt_user prompt
      @value
    end

    ##
    # Prompts the user for a value
    def self.prompt_user(prompt)
      loop do
        print prompt
        @value = gets.chomp.to_s
        break if confirm_input
      end
    end

    ##
    # Confirms the value entered by the user
    def self.confirm_input
      puts "You have entered: #{@value}"
      print 'Is this correct? (Y/N) => '
      confirm = gets.chomp.to_s.upcase
      return false unless confirm == 'Y'
      true
    end
  end
end
