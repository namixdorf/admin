

```yaml
name: Article
sort:
  column: position
fields:
  title:
    type: text
    label: 'Main Title'
  copy: wysiwyg
  links: association
  category:
    type: collection
    collection: Article::VALID_CATEGORIES
filters:
  featured:
    scope: featured
  by_issue:
    association: issue
```  


# class QuizDecorator
#   def title
#     { label:"Quiz Title", type:"Text", }
#   end


* Eliminate the need for :finder argument by forcing 'id' column as to_param?
* Add default inputs for SimpleForm (take cues from Webflow?):
  * :color?
* Add 'type' to code editor (html, json, ruby)

* Filters
  * Specify in YAML:
    filter_by:
      job_type:
* Polymorphic association

* "Permanent" object concept - don't allow deletion?
  * Simply have the object respond to a permanent? method

* 'Preview' button ?

## UI
* Add help text to YAML config

## Collections
* Simple 'options' list (ie. User#user_type)
* Specifying the collection for an association

## Polymorphic associations
* How to handle selection & assignment
* Possibly related to Collections solution above?

## WYSIWYG - Images & Files
* Need to create a proxy controller for browsing S3 files (and updating/deleting them)
* Create similar functionality for Files (a FileManager plugin)
* Keep this generalized so that if needed we could swap out the S3 backend?

## Generators
* Generate the YAML for a model (go through the admin_fields step and then write to a file)
* Generate directories for extensibility

## Extensibility
* Custom controller actions
* Custom views
* Customizing views through configs
* SimpleForm fields

## Documentation
* Polymorphic belongs_to: validating "inclusion: :in" for the 'type' column filters the list of classes to pick from.
* Configuring AWS will enable blanket uploads to S3 bucket from WYSIWYG editor
