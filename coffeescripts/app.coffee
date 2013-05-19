class PageController
  @pageToLoad: ->
    url = document.location.toString()
    if url.indexOf("#") >= 0
      hash = url.substring(url.indexOf("#")+1)
      "data/json/#{hash}.json"
    else
      "data/json/12-13-cm0109-translate-c.json"
window.PageController = PageController

class PageRenderer
  load: (file) ->
    $.ajax(url: file, dataType: 'json').done (data) =>
      @render(data)

  render: (data) =>
    @renderHeader(data)
    @renderEvents(data.events)

  renderHeader: (data) ->
    presentMembers = for member in data.present_members
      "<span class='member'>#{member}</span>"

    absentMembers = for member in data.absent_members
      "<span class='member absent'>#{member}</span>"

    $("#presented_members").html(presentMembers.join(''))
    $("#absent_members").html(absentMembers.join(''))

    date = new Date(data.date)
    $("#time").html("#{date.getFullYear()}年 #{date.getMonth()+1}月 #{date.getDate()}日")

  renderEvents: (events) ->
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