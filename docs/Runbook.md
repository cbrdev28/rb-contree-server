# Runbook

## Setup

- Xcode & dev tools
- iTerm2
  - `bash_profile` [template](https://raw.githubusercontent.com/cbrdev28/rb-contree-server/master/docs/bash-profile-template.txt)

At this point we should be able to checkout the project from this git repository.
The next steps will be interacting directly with the project.

## Notes & Steps

### Installing Ruby & Rails dependencies

Inspired from:

- https://cloud.google.com/ruby/docs/setup
- https://www.railstutorial.org/book/beginning

* The `bootstrap.sh` script will attempt to install:
  - [homebrew](https://brew.sh)
    - [jq](https://stedolan.github.io/jq/): a helper to parse json in bash script
  - [rbenv](https://github.com/rbenv/rbenv#installation)...
    - Update your `~/.bash_profile` to add:
    ```bash
    eval "$(rbenv init -)"
    ```

The installation of Ruby using rbenv must be done manually in the terminal, by running:

```bash
rbenv install <ruby_version>
```

- The `bootstrap2.rb` ruby script will attempt to install:
  - [Rails](https://guides.rubyonrails.org/getting_started.html)

### Starting with Rails

- `rails new . --api -T`
- `bundle install`
- `rails s`
- Visit: http://localhost:3000/

### Starting with Google Cloud Platform

- Created project named _Contree Server_
- Project id: `contree-server`
- Enabled [billing](https://console.cloud.google.com/project/_/settings?_ga=2.219190108.-471678104.1567293403) on Google Cloud Platform
- Installing [GC (Google Cloud) SDK](https://cloud.google.com/sdk/docs/)
- [Deploy steps](https://cloud.google.com/ruby/rails/appengine#deploy-to-app-engine)

  - `app.yaml` file
  - `bundle exec rails secret`
  - `gcloud app create`
  - Attempt to: `RAILS_ENV=production bundle exec rails server`
  - `gcloud app deploy`: not quite successful...

### Experimenting with linter, prettier, ...

- VSCode extension: prettier (but does not update ruby files...)
- [Rubocop](https://rubocop.readthedocs.io/en/latest/installation/)

  - Add to Gemfile: `gem 'rubocop', '~> 0.74.0', require: false`
  - Run `bundle install`
  - Add config file: `.rubocop.yml`, [source](https://rubocop.readthedocs.io/en/latest/configuration/#setting-the-style-guide-url)

  ```
  AllCops:
  StyleGuideBaseURL: https://rubystyle.guide
  ```

  - Add: `gem 'rubocop-rails'`, [source](https://rubygems.org/gems/rubocop-rails_config)
  - Edit `.rubocop.yml` config file, [source](https://github.com/rubocop-hq/rubocop-rails)

  ```
  require: rubocop-rails

  Rails:
    StyleGuideBaseURL: https://rails.rubystyle.guide
  ```

  - Run: `bundle exec rubocop`

- Rubocop in VSCode: [source](https://github.com/rubyide/vscode-ruby/blob/master/docs/legacy.md)
  - Install the extension in VSCode (and restart)
  - Edit `settings.json` (VSCode):
  ```
  "[ruby]": {
        "editor.formatOnSave": true
    },
    "ruby.format": "rubocop",
    "editor.formatOnSaveTimeout": 1500
  ```
  - Restart VSCode

### My first welcome JSON

- Add `get 'welcome/show'` to `./config/routes.rb`
- Make `./controllers/welcome_controller.rb`
  - Implement basic `show` function to set a title
- Make `./views/welcome/show.json.jbuilder`
  - Use [jbuilder](https://github.com/rails/jbuilder) to make some json
- Add `jbuilder` in Gemfile
- Run the server
  - `bundle install`
  - `bundle exec rails s`
- Test
  - Browser: `http://localhost:3000/welcome/show.json`
  - Command line: `curl --request GET localhost:3000/welcome/show.json`
