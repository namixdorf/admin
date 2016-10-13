# CohesiveAdmin

CohesiveAdmin is a simple Rails engine that give you a basic, customizeable admin interface for users to make database updates. The goal of this engine is to be unobtrusive, decoupled from your Rails application, and most importantly - simple. Customization is handled via custom [Simple Form](https://github.com/plataformatec/simple_form) inputs and YAML configuration.

## CohesiveAdmin Models
#### CohesiveAdmin::User
This is the basic user model used for logging in to the CMS.

## UI
CohesiveAdmin uses the [Materialize](http://materializecss.com/) CSS framework.


## Best Practices
  * Make use of the :inverse_of option in your ActiveRecord relationships. This prevents nested fields on an object from displaying in the form. http://guides.rubyonrails.org/association_basics.html#bi-directional-associations
  * For nested attributes functionality, be sure that both the parent model and the nested attributes model are managed resources (`cohesive_admin`)

## WYSIWYG Editor and File Uploads
We use the [Froala WYSIWYG Editor](https://www.froala.com/wysiwyg-editor) for rich text fields. Froala has built-in support for direct asset uploads to [Amazon S3](https://aws.amazon.com/s3/). This makes for a convenient way to allow users to upload images and files to one central location without having to model them in your application. These assets should be stored independent of any other assets - either in a specific subdirectory in S3 (see the `key_start` param), or in a completely separate bucket. **NOTE:** Because enabling S3 uploads via Froala requires specific CORS configuration on the bucket, carefully consider whether or not using a shared bucket is appropriate for your situation.


## Installation
Add it to your Gemfile:

```ruby
gem 'cohesive_admin', git: 'git@github.com:cohesivecc/admin.git', tag: "<specific tag number here>"
```

Install the migrations:

```console
rake cohesive_admin:install:migrations
```

In development, password validation is disabled for both user creation, as well as authentication. This makes it easy to create test users in development and log in to the admin interface with any account.

To create a new user via the IRB console:

```ruby
u = CohesiveAdmin::User.create({ email: 'bob@example.com', password: 'doesNOTmatter', name: 'Admin User' })
```
