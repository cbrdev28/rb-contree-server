# Runbook

## Setup

- Xcode & dev tools
- iTerm2
  - `bash_profile` [template](https://raw.githubusercontent.com/cbrdev28/rb-contree-server/master/docs/bash-profile-template.txt)
- [Git bash completion](https://github.com/bobthecow/git-flow-completion/wiki/Install-Bash-git-completion)
  - `brew install git bash-completion`
  - Edit `~/.bash_profile`:
  ```bash
  [[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
  ```

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
  - `gcloud init`
  - `gcloud app create`
  - Attempt to: `RAILS_ENV=production bundle exec rails server` (should not be needed)
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

### Removing unused stuff...

- Removed [spring](https://github.com/rails/spring)
- Remove [active jobs](https://edgeguides.rubyonrails.org/active_job_basics.html)
- Remove [action mailer](https://guides.rubyonrails.org/action_mailer_basics.html)
- Remove [action mailbox](https://guides.rubyonrails.org/action_mailbox_basics.html)
- Remove [action text](https://edgeguides.rubyonrails.org/action_text_overview.html)

### Making Rubocop green

- Edited `.rubocop.yml` and fixed every errors
- Edited `settings.json` from VScode:

````json
"ruby.useBundler": true,
    "ruby.lint": {
        "rubocop": {
            "useBundler": true
        }
    }
    ```
````

### Experimenting [Sorbet](https://sorbet.org/docs/adopting)

It was just a very quick try.

- Sorbet made some changes automatically adding `# typed: ...`
- Edited `welcome_controller.rb` to experiment a bit
- I'm not sure if `sorbet-runtime` works properly
- To run it: `bundle exec srb tc`

### First step with [GraphQL](https://www.howtographql.com/graphql-ruby/1-getting-started/)

#### Install

- `bundle exec rails db:create`
- Add [graphql](https://rubygems.org/gems/graphql) gem in Gemfile
- `bundle update`
- `bundle exec rails generate graphql:install`
- ~Edit Gemfile to set version for [graphiql-rails](https://rubygems.org/gems/graphiql-rails) gem~
- [graphiql-rails](https://rubygems.org/gems/graphiql-rails) gem is not installed by default for a Rails API, we can add it manually in the `development` group:

```ruby
group :development do
  # Other gems ...
  gem 'graphiql-rails', '~> 1.7.0'
end
```

- graphiql will still not work properly, the following steps should fix it:
  - In `application.rb`, add: `require 'sprockets/railtie'`
  - Create the directory: `app/assets/config/`, and add the file: `manifest.js`
  - Add the following content to `manifest.js`:

```javascript
//= link graphiql/rails/application.css
//= link graphiql/rails/application.js
```

- `bundle update`

#### User model

- `bundle exec rails generate model User name email password_digest`
- `bundle exec rails db:migrate`
- Update `app/models/user.rb`:

```ruby
class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end
```

- To support `has_secure_password`, edit Gemfile to add [brcypt](https://rubygems.org/gems/bcrypt)
- `bundle update`

_From there I'll just summarize the steps, the details are pretty much similar to this [tutorial](https://www.howtographql.com/graphql-ruby/4-authentication/)_

- Create GraphQL user type: `app/graphql/types/user_type.rb`
- Create authentication mutation
  - Create input type for authentication, i.e. what users need to provide to sign up (email, password): `app/graphql/types/sign_up_input.rb`
  - Create mutation for creating user: `app/graphql/mutations/create_user.rb`
  - Add mutation to mutations lists: `app/graphql/types/mutation_type.rb`
- Test with graphiql

_At this point, I encountered an error with GraphQL and decided to step back and start over_

#### Clean up database

The goal is to get back to the point right after installing GraphQL and graphiql

- Delete all the files for the user model:
  - `create_user.rb`
  - `sign_up_input.rb`
  - `user_type.rb`
  - `user.rb`
- `bundle exec rake db:reset`
- `git clean -dfx`
- `bundle update`

#### Steps from starting with GraphQL:

- `bundle exec rails db:create`
- `bundle exec rails generate graphql:install`
- `bundle update`
- Test graphiql locally: `localhost:3000/graphiql`

_From there I'm making a simple `Tutorial` object in the database and adding some query and mutation for it_
_And I removed [sorbet](https://sorbet.org)_
