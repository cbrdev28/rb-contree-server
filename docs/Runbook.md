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

_From there I'm making a simple `Tutorial` object in the database and adding some query and mutation for it._

_And I removed [sorbet](https://sorbet.org)_

## Get back on track!

This project has been on hold for a while and this chapter is me getting back on track.

When Greg was around we implemented a proof of concept to play parite by using a version of this server, here is the pull request: https://github.com/cbrdev28/rb-contree-server/pull/16

The next goal is to support a proper implementation for authentication and queries which required valid credentials.

One particular command I wanted to save somewhere, to run the server locally: `bundle exec rails s -b 0.0.0.0`

### Updates & dependencies

My first task will be to make sure everything is up to date, from my system to every tool being used in this project:

- System Mac OS (which apparently is going to take a couple of hours...), Xcode, etc...
  - It took pretty much a day to update everything System & App Store
  - Don't forget to run Xcode after the update so it installs additional tools
- I also ran the following commands:
  - `brew update`
  - `brew cleanup`
  - `brew doctor`
- Now back at the project level:
  - `bundle install`
  - `bundle exec rails s`

Everything seems to work fine: the Rails welcome page, my first welcome JSON (http://localhost:3000/welcome/show.json), and graphiql (http://localhost:3000/graphiql).

#### Update to Ruby v2.7.1 (was v2.6.4)

- Change ruby version in `.ruby-version` for rbenv
- Change ruby version in Gemfile
- Install ruby v2.7.1 with rbenv:
  - It was not available in the list of all versions so I tried: `brew update && brew upgrade ruby-build`
  - And followed by: `brew doctor/cleanup`
  - Install ruby 2.7.1 with rbenv: `rbenv install 2.7.1`
  - Verified with: `rbenv versions`
- Run `bundle install` & verified with `bundle exec rails s`

#### Bump Rails from 6.0.0 to 6.0.3.3

- Updated version in Gemfile but `bundle install` failed
- Tried: `bundle update` & `bundle install` again
- Verified with `bundle exec rails s`

_For other minor dependencies, I simply had to update the Gemfile and run `bundle install` & verify with `bundle exec rails s`._

- The rubocop upgrade required a few changes that were explained while running the commands:
  - `bundle install` required to run `bundle update rubocop`
  - I had to edit the `.rubocop.yml` file with `NewCops: enable`
  - And had to make `bundle exec rubocop` green again

### First User Auth attempt

For now I don't really want to describe every step in details, but here is the idea.
I got inspired from 2 tutorials:

- Inspiration to implement user model with GraphQl and some authentication logic:
  - https://www.howtographql.com/graphql-ruby/4-authentication/
  - I decided to use `bcrypt` too, for password verification
- Inspiration to make my own class for a `AuthTokenSessionManager`:
  - https://www.programmableweb.com/news/how-to-implement-graphql-api-rails/how-to/2017/12/09
  - Basically I will "abstract" the implementation by making my own class, and will decide later what to use for a more secure token management

I need to make a list of things I learnt, by experimenting with my first user model:

- About the `bcrypt` gem and what it provides:
  - The `has_secure_password` that we add to our `user.rb` model class
    - Requires the user model to have a field `password_digest`, where it will store an encrypted version of the `password`
    - Optionally, we could use `password_confirmation`: https://api.rubyonrails.org/classes/ActiveModel/SecurePassword/ClassMethods.html
  - It provides a method `authenticate`, which takes the string password as a parameter to verify user authentication
- About Rack Cors
  - It's a gem which is required if we want our API to be called from "the outside"
  - I still need to add it in my Gemfile
  - It requires some configuration, one way is to add this block of code directly in the `config/application.rb`:
  ```
  config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins '*'
      resource '*', headers: :any, methods: [:get, :post, :options]
    end
  end
  ```
  - This is not secure and not clean, this tutorial video shows a different way for the config: https://youtu.be/z18zLCAg7UU
- About the usage of session in Rails
  - By default it is disabled for Rails API! I need to figure out how to set it up
  - UPDATE: I was not able to find a proper way to setup and use sessions with Rails API

The next idea is to look into using headers:

- Client apps would pass the user auth token in the header for each request
  - I made a helper which takes the `request` from Rails and parse the header to find our custom `'Contree-Auth-Token'` one
  - This helper also builds the `context` for our GraphQl schema by passing the `current_user`
- The server would use this to verify the current user is authenticated
  - We can access the `current_user` from the GraphQl context which actually calls our `UserAuthTokenManager` class
  - This manager class is our very fist implementation to keep user session in memory, which is not great and not safe!
  - Later on, we could refactor this class to use a safer method (Devise, JsonWebToken, ...)

Note: defining queries with Resolvers (class based API):

- https://graphql-ruby.org/fields/resolvers.html
- Part 1: https://www.endpoint.com/blog/2019/02/28/converting-graphql-ruby-resolvers-to-the-class-based-api
- Part 2: https://www.endpoint.com/blog/2019/03/29/eliminating-resolvers-in-graphql-ruby

I need to commit some changes and check on Rubocop status. Next steps will be:

- Create the sign in mutation
  - Authenticate users by verifying their password using `bcrypt`
  - Create their auth token and store their session with our `UserAuthTokenManager`
  - Returns the user object and the `auth_token`
- Provide a way to get the current user, with a query only for users who are signed-in, to test our `current_user` strategy
  - This query takes no parameters and will rely on the `auth_token` provided in the headers to fetch and return the current user
  - This is basically a way for our client app to retrieve the current user session based on the `auth_token`
