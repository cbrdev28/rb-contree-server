#!/usr/bin/ruby
# frozen_string_literal: true

# This just a script to check/install dependencies
# No need to restrict the lenght of this method from rubocop

def main
  puts 'Ruby bootstrap...'
  puts 'Check sqlite3'
  if system('sqlite3 --version')
    puts 'Ok'
  else
    puts 'Ko: sqlite3 is required'
    puts 'https://guides.rubyonrails.org/getting_started.html'
    exit 1
  end

  puts 'Update Ruby gem manager'
  system('gem update --system')

  puts 'Install bundler'
  system('gem install bundler')

  puts 'Install rails'
  system('gem install rails')
  system('rails --version')
end

if $PROGRAM_NAME == __FILE__
  main
else
  exit 1
end
