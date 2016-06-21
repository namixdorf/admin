#= require jquery2
#= require jquery_ujs
#= require_tree ./includes

$.FroalaEditor.DEFAULTS.key = 'Ua2Pe2HTPYh1RNc2E1KDc1==';
$ ->
  # kick things off
  $('select').material_select();
  $('textarea.wysiwyg').froalaEditor()
