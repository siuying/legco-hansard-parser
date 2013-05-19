class PageRenderer
  load: (file) ->
    $.ajax(url: file, dataType: 'json').done (data) =>
      @render(data)

  render: (data) =>
    console.log "render data:"
    @renderHeader(data)
    @renderEvents(data.events)

  renderHeader: (data) ->
    presentMembers = for member in data.present_members
      "<span class='member'>#{member}</span>"

    absentMembers = for member in data.absent_members
      "<span class='abs_member'>#{member}</span>"

    $("#presented_members").html(presentMembers.join(''))
    $("#absent_members").html(absentMembers.join(''))

  renderEvents: (events) ->
    console.log('render events');
    output = for event in events
      @renderEvent(event)
    html = output.join('')
    $("#events").append(html)

  renderEvent: (event) ->
    output = ""
    if event.type == "speech"
      speaker = "<div class='speaker'>#{event.speaker.full}</div>"
      text = "<div class='text'>#{event.text}</div>"
      output = "<div class='event speech'><pre>#{speaker}#{text}</pre></div>"
    else
      text = "<div class='text'>#{event.text}</div>"
      output = "<div class='event action'>#{text}</div>"
    return output

window.PageRenderer = PageRenderer