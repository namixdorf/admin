
# Custom SimpleForm input used for integration with Refile gem

# NEAL:
#
# Refile's convention (when you call attachment_field) is to create two inputs - one hidden and one of type='file'
# For our custom file inputs, we rely on clicking the label to open the file chooser (ie. <label for="[id here]">)
# We also append a 'remove' button that appears after a file is 'direct' uploaded

# TODO: include the display of the thumbnail, add Dropzone?
class RefileInput < SimpleForm::Inputs::Base

  # def input(wrapper_options = nil)
  #   refile_options = [:presigned, :direct, :multiple]
  #   merged_input_options = merge_wrapper_options(input_options.slice(*refile_options).merge(input_html_options), wrapper_options)
  #   @builder.attachment_field(attribute_name, merged_input_options)
  # end

  attr_reader :has_file

  def initialize(builder, attribute_name, column, input_type, options = {})
    super
    @has_file = @builder.object.send(attribute_name)
    @removeable = options[:removeable] != false
    @options[:label] = false # ||= "Select File"

    if @has_file
      @options[:label].gsub!(/select/i, 'Replace') rescue nil
    end

  end

  def input(wrapper_options=nil)
    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)

    # grab the Refile attachment_field markup
    html = template.content_tag(:div, raw(%Q{
      <span>Select File</span>
      #{@builder.attachment_field(attribute_name, merged_input_options)}
      }), class: 'btn')
    html += template.content_tag(:div, raw(%Q{<input class="file-path validate" type="text">}), class: 'file-path-wrapper')

    html = template.content_tag(:div, raw(html), class: 'file-field input-field')

    # show thumbnail
    if @has_file && (attacher = @builder.object.public_send("#{attribute_name}_attacher") rescue nil)

      link_html = raw %Q{
                    #{template.image_tag(template.attachment_url(@builder.object, attribute_name, :fill, 150, 150))}<br />
                    #{attacher.filename}
                    }
      link_html = template.link_to(link_html, template.attachment_url(@builder.object, attribute_name), target: '_blank')

      if @removeable
        # Add the 'remove' button
        link_html += @builder.input("remove_#{attribute_name}", as: :boolean, label: "Remove File?", wrapper_html: { class: 'filled-in' })
      end

      link_html = template.content_tag(:div, link_html)
      html += raw(link_html)
    end

    html.html_safe
  end

end
