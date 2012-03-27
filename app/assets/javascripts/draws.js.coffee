# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$('#main_form').live('ajax:success',(event,data)->
  jas = $('#jas')
  str = ''
  if data.jas_err?
    jas.html("<span style=\"color:red\">#{data.jas_err}</span>")
    return

  if not data['nnull']?
    for k,v of data
      if k != 'visit_count'
        str+= "<br /> #{k} : #{v}"

    $('#draw_count').val('')
    $('#draw_letters').val('')
    jas.html(str)
  else
    jas.html('所给条件没有返回结果 @_@...<br /> no result @_@...')

  $('#visit').html(data['visit_count'])
)

$('#main_form').live('ajax:before',(event,data)->
  jas = $('#jas')
  jas.html('等待中请稍候...<br />please wait...<br />')
)

$('#foo').live('click',(event)->
  alert "fuck you all"
)
