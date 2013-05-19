class PageController
  @load: ->
    $.ajax(url: 'data/hansard_list.json', dataType: 'json').done (data) =>
      @renderList(data)

  @renderList: (data) ->
    links = $("#links")
    for item in data
      console.log("item: #{item}")
      name = item.date
      for url in item.hansard
        console.log(" #{url}")
        parts = url.split("/")
        filename = parts[parts.length - 1]
        basename = filename.split(".")[0]
        links.append("<li><a href='hansard.html#12-13-#{basename}'>#{name}</a></li>")

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
    if data.present_members
      presentMembers = for member in data.present_members
        "<span class='member'>#{member}</span>"
      $("#presented_members").html(presentMembers.join(''))

    if data.absent_members
      absentMembers = for member in data.absent_members
        "<span class='member absent'>#{member}</span>"
      $("#absent_members").html(absentMembers.join(''))

    date = new Date(data.date)
    $("#time").html("#{date.getFullYear()}年 #{date.getMonth()+1}月 #{date.getDate()}日")

  renderEvents: (events) ->
    for event in events
      @renderEvent(event)

  renderEvent: (event) ->
    output = ""
    if event.type == "speech"
      speaker = "<div class='speaker'>#{event.speaker.full}</div>"
      text = event.text
      supplement = event.supplement

      text = "" unless text
      supplement = "" unless supplement

      if (text && text != "") || (supplement && supplement != "")
        text = "<div class='text'>#{text}</div>"
        supplement = "<div class='supplement'>#{supplement}</div>"
        output = "<div class='event speech'><pre>#{speaker}#{text}#{supplement}</pre></div>"
    else
      text = "<div class='text'>#{event.text}</div>"
      output = "<div class='event action'>#{text}</div>"
    $("#events").append(output)

window.PageRenderer = PageRenderer