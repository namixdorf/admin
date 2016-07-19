#= require jquery2
#= require jquery-ui
#= require jquery_ujs
#= require materialize-sprockets
#= require_tree ./includes

$ ->
  # kick things off
  $('select').material_select();
  $('textarea.code').each(() ->
    CodeMirror.fromTextArea($(@)[0], {
      lineNumbers: true,
      styleActiveLine: true,
      matchBrackets: true,
      theme: 'material',
      mode: 'javascript'
    })
  )
  $(".button-collapse").sideNav()

  $('[data-sortable]').sortable({
    containment: 'parent',
    cursor: 'move',
    update: () ->
      list = $(@)
      $.ajax({
        type: 'put',
        data: list.sortable('serialize'),
        dataType: 'script',
        complete: (request) ->
          list.children().effect('highlight')
          return
        url: list.attr('data-url')
      })
    })


# asynchronously load Froala and S3 settings for security purposes
$(document).on( 'froala.init', (e, key, s3config) ->
  $.FroalaEditor.DEFAULTS.key = key
  
  config = {
    zIndex: 999,
    heightMin: 300,
    toolbarButtons: ['fullscreen', 'bold', 'italic', 'underline', 'strikeThrough', 'subscript', 'superscript', 'fontFamily', 'fontSize', '|', 'color', 'emoticons', 'inlineStyle', 'paragraphStyle', '|', 'paragraphFormat', 'align', 'formatOL', 'formatUL', 'outdent', 'indent', 'quote', 'insertHR', 'insertLink', 'insertImage', 'insertVideo', 'insertFile', 'insertTable', 'undo', 'redo', 'clearFormatting', 'selectAll', 'html']
  }
  if s3config
    config.imageUploadToS3 = {
      bucket:   config.bucket,
      region:   config.region,
      keyStart: config.key_start + 'images/',
      callback: (url, key) ->
        # // The URL and Key returned from Amazon.
        console.log (url);
        console.log (key);
      params: {
        acl: config.acl,
        AWSAccessKeyId: config.access_key_id,
        policy: config.policy,
        signature: config.signature,
      }
    }

  $('textarea.wysiwyg').froalaEditor(config)
)
