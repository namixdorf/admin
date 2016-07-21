class PolymorphicInput < SimpleForm::Inputs::Base


  def initialize(builder, attribute_name, column, input_type, options = {})
    super
    @options[:label] = false
  end

  def input(wrapper_options=nil)
    reflection = @builder.object.class.reflections[attribute_name.to_s]
    # TODO: handle has_many etc.
    if reflection.polymorphic?

      type_attribute = reflection.foreign_type
      key_attribute = reflection.foreign_key

      type_input = @builder.input(type_attribute, collection: CohesiveAdmin.config.managed_models.collect {|m| [m.admin_display_name, m.name] }, input_html: { data: { 'polymorphic-type' => attribute_name, 'initial' => @builder.object.send(type_attribute) }})

      key_input = @builder.input(key_attribute, collection: [], input_html: { data: { 'polymorphic-key' => attribute_name, 'initial' => @builder.object.send(key_attribute) }})

      html = %Q{
        <div class="row">
          <div class="col m6">#{type_input}</div>
          <div class="col m6">#{key_input}</div>
        </div>
      }

      html.html_safe

    end

  end

end
