
$ ->
  $('select[data-polymorphic-type]').on('change', () ->
    field         = $(@).data('polymorphic-type')
    initial_type  = $(@).data('initial')
    if (id_input = $('select[data-polymorphic-key="'+field+'"]')).length && model = CohesiveAdmin.managed_models[$(@).val()]

      initial_id  = if model.class_name == initial_type then id_input.data('initial') else null
      console.log(model.class_name, initial_type, initial_id)
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
          id_input.html(opts.join(''))
          id_input.material_select()
          return
        complete: (request) ->
          return
      })
  ).trigger('change')
