# Runbook

## Setup

* Xcode & dev tools
* iTerm2
  * `bash_profile` [template](https://raw.githubusercontent.com/cbrdev28/rb-contree-server/master/docs/bash-profile-template.txt)

At this point we should be able to checkout the project from this git repository.
The next steps will be interacting directly with the project.

## Notes & Steps

### Installing Ruby & Rails dependencies

Inspired from:

* https://cloud.google.com/ruby/docs/setup
* https://www.railstutorial.org/book/beginning


* The `bootstrap.sh` script will attemp to install:
  * [homebrew](https://brew.sh)
    * [jq](https://stedolan.github.io/jq/): a helper to parse json in bash script
  * [rbenv](https://github.com/rbenv/rbenv#installation)...
    * Update your `~/.bash_profile` to add:
    ``` bash
    eval "$(rbenv init -)"
    ```


The installation of Ruby using rbenv must be done manually in the terminal, by running:
``` bash
rben install <ruby_version>
```


* The `bootstrap2.rb` ruby script will attempt to install:
  * [Rails](https://guides.rubyonrails.org/getting_started.html)

### Starting with Rails

* `rails new . --api -T`
* `bundle install`
* `rails s`
* Visit: http://localhost:3000/

### Starting with Google Cloud Platform

* Created project named _Contree Server_
* Project id: `contree-server`
* Enabled [billing](https://console.cloud.google.com/project/_/settings?_ga=2.219190108.-471678104.1567293403) on Google Cloud Platform
* Installing [GC (Google Cloud) SDK](https://cloud.google.com/sdk/docs/)
* [Deploy steps](https://cloud.google.com/ruby/rails/appengine#deploy-to-app-engine)
  * `app.yaml` file
  * `bundle exec rails secret`
  * `gcloud app create`
  * Attempt to: `RAILS_ENV=production bundle exec rails server`
  * `gcloud app deploy`
