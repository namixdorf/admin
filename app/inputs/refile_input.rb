
# Custom SimpleForm input used for integration with Refile gem

# NEAL:
#
# Refile's convention (when you call attachment_field) is to create two inputs - one hidden and one of type='file'
# For our custom file inputs, we rely on clicking the label to open the file chooser (ie. <label for="[id here]">)
# We also append a 'remove' button that appears after a file is 'direct' uploaded

# TODO: include the display of the thumbnail, add Dropzone?
class RefileInput < SimpleForm::Inputs::Base

  attr_reader :has_file

  def initialize(builder, attribute_name, column, input_type, options = {})
    super
    @has_file = @builder.object.send(attribute_name)
    @removeable = options[:removeable] != false
    @options[:label] ||= "Select File"

    if @has_file
      @options[:label].gsub!(/select/i, 'Replace') rescue nil
    end

  end

  def input(wrapper_options=nil)
    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)

    # grab the Refile attachment_field markup
    html = @builder.attachment_field(attribute_name, merged_input_options)

    # manually compose the ID the same way FormBuilder does with sanitize_to_id
    key = "#{object_name}_#{attribute_name}".to_s.delete(']').gsub(/[^-a-zA-Z0-9:.]/, "_")

    # Add the 'remove' button
    html += raw %Q{<a data-trigger="cms.form.refile_remove" data-refile-name="#{object_name}[#{attribute_name}]" data-refile-id="#{key}" data-tooltip title="Remove file" class="refile-remove has-tip tip-top radius text-alert fa-before fa-compact fa-remove"></a>}

    # show thumbnail
    if @has_file && (attacher = @builder.object.public_send("#{attribute_name}_attacher") rescue nil)
      if attacher.image?
        link_html = raw %Q{
                      #{template.image_tag(template.attachment_url(@builder.object, attribute_name, :limit, 150, 150))}<br />
                      #{attacher.filename}
                      }
      else
        link_html = raw %Q{ <span class="fa-stack">
                          <i class="fa fa-circle fa-stack-2x"></i>
                          <i class="fa fa-#{@builder.object.fa_class} fa-stack-1x fa-inverse"></i>
                        </span>
                        #{attacher.filename}}
      end
      link_html = template.link_to(link_html, template.attachment_url(@builder.object, attribute_name), target: '_blank')

      if @removeable
        link_html += @builder.input("remove_#{attribute_name}", as: :boolean, boolean_style: :inline, label: raw("&nbsp;&nbsp;Remove this #{attribute_name.to_s.humanize}?"), wrapper_html: { class: 'fa-switch text-alert' })
      end

      link_html = template.content_tag(:div, link_html)
      html += raw(link_html)
    end

    html.html_safe
  end

end
