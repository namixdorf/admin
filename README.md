# CohesiveAdmin

CohesiveAdmin is a simple Rails engine that give you a basic, customizeable admin interface for users to make database updates. The goal of this engine is to be unobtrusive, decoupled from your Rails application, and most importantly - simple. Customization is handled via custom [Simple Form](https://github.com/plataformatec/simple_form) inputs and YAML configuration.

## CohesiveAdmin Models
#### CohesiveAdmin::User
This is the basic user model used for logging in to the CMS.

## UI
CohesiveAdmin uses the [Materialize](http://materializecss.com/) CSS framework.

## Installation
Add it to your Gemfile:

```ruby
gem 'cohesive_admin', git: 'git@github.com:cohesivecc/admin.git', tag: "<specific tag number here>"
```

Install the migrations:

```console
rake cohesive_admin_engine:install:migrations
```
