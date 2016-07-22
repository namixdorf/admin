
$(document).on( 'cohesive_admin.initialized', (e) ->
  
  $('select[data-polymorphic-type]').on('change', () ->
    field         = $(@).data('polymorphic-type')
    initial_type  = $(@).data('initial')
    id_input      = $('select[data-polymorphic-key="'+field+'"]')
    # clear id_input
    id_input.html("<option value></option>").material_select()

    if (id_input.length && model = CohesiveAdmin.config.managed_models[$(@).val()])
      initial_id = if model.class_name == initial_type then id_input.data('initial') else null
      $.ajax({
        type: 'get',
        url: model.uri,
        dataType: 'json',
        data: { page: 'all' },
        success: (data) ->
          opts = ["<option value></option>"]
          $.each(data, (i, x) ->
            selected = if x.id == initial_id then ' selected' else ''
            opts.push('<option value="'+x.id+'" '+selected+'>'+x.to_label+'</option>')
          )
          id_input.html(opts.join('')).material_select()
          return
        complete: (request) ->
          return
      })
  ).trigger('change')
)
