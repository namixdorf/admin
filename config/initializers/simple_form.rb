# Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|
  # Wrappers are used by the form builder to generate a
  # complete input. You can remove any component from the
  # wrapper, change the order or even add your own to the
  # stack. The options given below are used to wrap the
  # whole input.
  config.wrappers :material_checkbox,
    hint_class: :field_with_hint, error_class: 'has-error' do |b|
    b.use :input
    b.use :label

    b.use :hint,  wrap_with: { tag: :span, class: 'help-block' }
    b.use :error, wrap_with: { tag: :span, class: 'error-block' }

    b.use :html5
    end

  config.wrappers :disabled_form do |b|
    b.use :label
    b.use :input, disabled: true, readonly: true
  end

  config.wrappers :default, class: 'input-field',
    hint_class: :field_with_hint, error_class: 'has-error' do |b|
    ## Extensions enabled by default
    # Any of these extensions can be disabled for a
    # given input by passing: `f.input EXTENSION_NAME => false`.
    # You can make any of these extensions optional by
    # renaming `b.use` to `b.optional`.

    # Determines whether to use HTML5 (:email, :url, ...)
    # and required attributes
    b.use :html5

    # Calculates placeholders automatically from I18n
    # You can also pass a string as f.input placeholder: "Placeholder"
    b.use :placeholder

    ## Optional extensions
    # They are disabled unless you pass `f.input EXTENSION_NAME => true`
    # to the input. If so, they will retrieve the values from the model
    # if any exists. If you want to enable any of those
    # extensions by default, you can change `b.optional` to `b.use`.

    # Calculates maxlength from length validations for string inputs
    # b.use :maxlength

    # Used for materializeCSS CharacterCounter
    # b.use :length

    # Calculates pattern from format validations for string inputs
    b.optional :pattern

    # Calculates min and max from length validations for numeric inputs
    # b.use :min_max

    # Calculates readonly automatically from readonly attributes
    b.optional :readonly

    ## Inputs
    b.use :input
    b.use :label

    b.use :hint,  wrap_with: { tag: :span, class: 'help-block' }
    b.use :error, wrap_with: { tag: :span, class: 'error-block' }

    ## full_messages_for
    # If you want to display the full error message for the attribute, you can
    # use the component :full_error, like:
    #
    # b.use :full_error, wrap_with: { tag: :span, class: :error }
    end

  # The default wrapper to be used by the FormBuilder.
  config.default_wrapper = :default

  # Define the way to render check boxes / radio buttons with labels.
  # Defaults to :nested for bootstrap config.
  #   inline: input + label
  #   nested: label > input
  config.boolean_style = :inline

  # Default class for buttons
  config.button_class = 'waves-effect waves-light btn'

  # Method used to tidy up errors. Specify any Rails Array method.
  # :first lists the first message for each field.
  # Use :to_sentence to list all errors for each field.
  # config.error_method = :first

  # Default tag used for error notification helper.
  config.error_notification_tag = :div

  # CSS class to add for error notification helper.
  config.error_notification_class = 'alert alert-danger'

  # ID to add for error notification helper.
  # config.error_notification_id = nil

  # Series of attempts to detect a default label method for collection.
  # config.collection_label_methods = [ :to_label, :name, :title, :to_s ]

  # Series of attempts to detect a default value method for collection.
  # config.collection_value_methods = [ :id, :to_s ]

  # You can wrap a collection of radio/check boxes in a pre-defined tag, defaulting to none.
  # config.collection_wrapper_tag = nil

  # You can define the class to use on all collection wrappers. Defaulting to none.
  # config.collection_wrapper_class = nil

  # You can wrap each item in a collection of radio/check boxes with a tag,
  # defaulting to :span. Please note that when using :boolean_style = :nested,
  # SimpleForm will force this option to be a label.
  # config.item_wrapper_tag = :span

  # You can define a class to use in all item wrappers. Defaulting to none.
  # config.item_wrapper_class = nil

  # How the label text should be generated altogether with the required text.
  # config.label_text = lambda { |label, required, explicit_label| "#{required} #{label}" }

  # You can define the class to use on all labels. Default is nil.
  # config.label_class = nil

  # You can define the default class to be used on forms. Can be overriden
  # with `html: { :class }`. Defaulting to none.
  # config.default_form_class = nil

  # You can define which elements should obtain additional classes
  # config.generate_additional_classes_for = [:wrapper, :label, :input]

  # Whether attributes are required by default (or not). Default is true.
  # config.required_by_default = true

  # Tell browsers whether to use the native HTML5 validations (novalidate form option).
  # These validations are enabled in SimpleForm's internal config but disabled by default
  # in this configuration, which is recommended due to some quirks from different browsers.
  # To stop SimpleForm from generating the novalidate option, enabling the HTML5 validations,
  # change this configuration to true.
  config.browser_validations = false

  # Collection of methods to detect if a file type was given.
  # config.file_methods = [ :mounted_as, :file?, :public_filename ]

  # Custom mappings for input types. This should be a hash containing a regexp
  # to match as key, and the input type that will be used when the field name
  # matches the regexp as value.
  # config.input_mappings = { /count/ => :integer }

  # Custom wrappers for input types. This should be a hash containing an input
  # type as key and the wrapper that will be used for all inputs with specified type.
  # config.wrapper_mappings = { string: :prepend }

  # Namespaces where SimpleForm should look for custom input classes that
  # override default inputs.
  # config.custom_inputs_namespaces << "CustomInputs"

  # Default priority for time_zone inputs.
  # config.time_zone_priority = nil

  # Default priority for country inputs.
  # config.country_priority = nil

  # When false, do not use translations for labels.
  # config.translate_labels = true

  # Automatically discover new inputs in Rails' autoload path.
  # config.inputs_discovery = true

  # Cache SimpleForm inputs discovery
  # config.cache_discovery = !Rails.env.development?

  # Default class for inputs
  # config.input_class = nil

  # Define the default class of the input wrapper of the boolean input.
  config.boolean_label_class = 'checkbox'

  # Defines if the default input wrapper class should be included in radio
  # collection wrappers.
  # config.include_default_input_wrapper_class = true

  # Defines which i18n scope will be used in Simple Form.
  # config.i18n_scope = 'simple_form'

  config.wrapper_mappings = { switch: :material_checkbox }
end







# # Use this setup block to configure all options available in SimpleForm.
# SimpleForm.setup do |config|
#   # Don't forget to edit this file to adapt it to your needs (specially
#   # all the grid-related classes)
#   #
#   # Please note that hints are commented out by default since Foundation
#   # does't provide styles for hints. You will need to provide your own CSS styles for hints.
#   # Uncomment them to enable hints.
#
#   config.wrappers :vertical_form, class: :input, hint_class: :field_with_hint, error_class: :error do |b|
#     b.use :html5
#     b.use :placeholder
#     b.optional :maxlength
#     b.optional :pattern
#     b.optional :min_max
#     b.optional :readonly
#     b.use :label_input
#     b.use :error, wrap_with: { tag: :small }
#
#     # b.use :hint,  wrap_with: { tag: :span, class: :hint }
#   end
#
#   config.wrappers :horizontal_form, tag: 'div', class: 'row', hint_class: :field_with_hint, error_class: :error do |b|
#     b.use :html5
#     b.use :placeholder
#     b.optional :maxlength
#     b.optional :pattern
#     b.optional :min_max
#     b.optional :readonly
#
#     b.wrapper :label_wrapper, tag: :div, class: 'small-3 columns' do |ba|
#       ba.use :label, class: 'right inline'
#     end
#
#     b.wrapper :right_input_wrapper, tag: :div, class: 'small-9 columns' do |ba|
#       ba.use :input
#       ba.use :error, wrap_with: { tag: :small }
#       # ba.use :hint,  wrap_with: { tag: :span, class: :hint }
#     end
#   end
#
#   config.wrappers :horizontal_radio_and_checkboxes, tag: 'div', class: 'row' do |b|
#     b.use :html5
#     b.optional :readonly
#
#     b.wrapper :container_wrapper, tag: 'div', class: 'small-offset-3 small-9 columns' do |ba|
#       ba.wrapper :tag => 'label', :class => 'checkbox' do |bb|
#         bb.use :input
#         bb.use :label_text
#       end
#
#       ba.use :error, wrap_with: { tag: :small }
#       # ba.use :hint,  wrap_with: { tag: :span, class: :hint }
#     end
#   end
#
#   # Foundation does not provide a way to handle inline forms
#   # This wrapper can be used to create an inline form
#   # by hiding that labels on every screen sizes ('hidden-for-small-up').
#   #
#   # Note that you need to adapt this wrapper to your needs. If you need a 4
#   # columns form then change the wrapper class to 'small-3', if you need
#   # only two use 'small-6' and so on.
#   config.wrappers :inline_form, tag: 'div', class: 'column small-4', hint_class: :field_with_hint, error_class: :error do |b|
#     b.use :html5
#     b.use :placeholder
#     b.optional :maxlength
#     b.optional :pattern
#     b.optional :min_max
#     b.optional :readonly
#
#     b.use :label, class: 'hidden-for-small-up'
#     b.use :input
#
#     b.use :error, wrap_with: { tag: :small }
#     # b.use :hint,  wrap_with: { tag: :span, class: :hint }
#   end
#
#   # Examples of use:
#   # - wrapper_html: {class: 'row'}, custom_wrapper_html: {class: 'column small-12'}
#   # - custom_wrapper_html: {class: 'column small-3 end'}
#   config.wrappers :customizable_wrapper, tag: 'div', error_class: :error do |b|
#     b.use :html5
#     b.optional :readonly
#
#     b.wrapper :custom_wrapper, tag: :div do |ba|
#       ba.use :label_input
#     end
#
#     b.use :error, wrap_with: { tag: :small }
#     # b.use :hint,  wrap_with: { tag: :span, class: :hint }
#   end
#
#   # CSS class for buttons
#   config.button_class = 'button'
#
#   # Set this to div to make the checkbox and radio properly work
#   # otherwise simple_form adds a label tag instead of a div arround
#   # the nested label
#   config.item_wrapper_tag = :div
#
#   # CSS class to add for error notification helper.
#   config.error_notification_class = 'alert-box alert'
#
#   # The default wrapper to be used by the FormBuilder.
#   config.default_wrapper = :vertical_form
# end