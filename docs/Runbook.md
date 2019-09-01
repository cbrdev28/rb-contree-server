# Runbook

## Setup

* Xcode & dev tools
* iTerm2
  * `bash_profile` (template)[https://www.link.com]

At this point we should be able to checkout the project from this git repository.
The next steps will be interacting directly with the project.

## Notes & Steps

### Installing Ruby & Rails dependencies

Inspired from:
* https://cloud.google.com/ruby/docs/setup
* https://www.railstutorial.org/book/beginning

* The `bootstrap.sh` script will attemp to install:
  * (homebrew)[https://brew.sh]
    * (jq)[https://stedolan.github.io/jq/]: a helper to parse json in bash script
  * (rbenv)[https://github.com/rbenv/rbenv#installation]...
    * Update your `~/.bash_profile` to add:
``` bash
eval "$(rbenv init -)"
```

The installation of Ruby using rbenv must be done manually in the terminal, by running:
``` bash
rben install <ruby_version>
```

* The `bootstrap2.rb` ruby script will attempt to install:
  * (Rails)[https://guides.rubyonrails.org/getting_started.html]
