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
      bucket:   s3config.bucket,
      region:   s3config.region,
      keyStart: s3config.key_start + 'images/',
      callback: (url, key) ->
        # // The URL and Key returned from Amazon.
        console.log (url);
        console.log (key);
      params: {
        acl: s3config.acl,
        AWSAccessKeyId: s3config.access_key_id,
        policy: s3config.policy,
        signature: s3config.signature,
      }
    }

  $('textarea.wysiwyg').froalaEditor(config)
)
