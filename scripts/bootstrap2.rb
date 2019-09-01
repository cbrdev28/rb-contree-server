#!/usr/bin/ruby

def main
    puts "Ruby bootstrap..."
    puts "Check sqlite3"
    if system("sqlite3 --version")
        puts "Ok"
    else
        puts "Ko: sqlite3 is required"
        puts "https://guides.rubyonrails.org/getting_started.html"
        exit 1
    end

    puts "Update Ruby gem manager"
    system("gem update --system")

    puts "Install bundler"
    system("gem install bundler")

    puts "Install rails"
    system("gem install rails")
    system("rails --version")
end

if $0 == __FILE__
    main
else
    exit 1
end
