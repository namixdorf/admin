
* Rework parsing of YAML configs for models
  * Allow simply specifying input type (string), or nested options
  * Need to build associations dynamically from YAML file, ie:

```yaml
name: Article
fields:
  title:
    type: text
    label: 'Main Title'
  copy: wysiwyg
  links: association
  category:
    type: collection
    collection: Article::VALID_CATEGORIES

```  


# class QuizDecorator
#   def title
#     { label:"Quiz Title", type:"Text", }
#   end


* Eliminate the need for :finder argument by forcing 'id' column as to_param?
* Add default inputs for SimpleForm (take cues from Webflow?):
  * :code (Ace code editor? - specify code type?)
  * :refile
  * :color

## WYSIWYG - Images & Files
* S3 uploads are working
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
