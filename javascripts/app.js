(function() {
  var PageController, PageRenderer,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  PageController = (function() {
    function PageController() {}

    PageController.load = function() {
      var _this = this;

      return $.ajax({
        url: 'data/hansard_list.json',
        dataType: 'json'
      }).done(function(data) {
        return _this.renderList(data);
      });
    };

    PageController.renderList = function(data) {
      var basename, filename, item, links, name, parts, url, _i, _len, _results;

      links = $("#links");
      _results = [];
      for (_i = 0, _len = data.length; _i < _len; _i++) {
        item = data[_i];
        console.log("item: " + item);
        name = item.date;
        _results.push((function() {
          var _j, _len1, _ref, _results1;

          _ref = item.hansard;
          _results1 = [];
          for (_j = 0, _len1 = _ref.length; _j < _len1; _j++) {
            url = _ref[_j];
            console.log(" " + url);
            parts = url.split("/");
            filename = parts[parts.length - 1];
            basename = filename.split(".")[0];
            _results1.push(links.append("<li><a href='hansard.html#12-13-" + basename + "'>" + name + "</a></li>"));
          }
          return _results1;
        })());
      }
      return _results;
    };

    PageController.pageToLoad = function() {
      var hash, url;

      url = document.location.toString();
      if (url.indexOf("#") >= 0) {
        hash = url.substring(url.indexOf("#") + 1);
        return "data/json/" + hash + ".json";
      } else {
        return "data/json/12-13-cm0109-translate-c.json";
      }
    };

    return PageController;

  })();

  window.PageController = PageController;

  PageRenderer = (function() {
    function PageRenderer() {
      this.render = __bind(this.render, this);
    }

    PageRenderer.prototype.load = function(file) {
      var _this = this;

      return $.ajax({
        url: file,
        dataType: 'json'
      }).done(function(data) {
        return _this.render(data);
      });
    };

    PageRenderer.prototype.render = function(data) {
      this.renderHeader(data);
      return this.renderEvents(data.events);
    };

    PageRenderer.prototype.renderHeader = function(data) {
      var absentMembers, date, member, presentMembers;

      if (data.present_members) {
        presentMembers = (function() {
          var _i, _len, _ref, _results;

          _ref = data.present_members;
          _results = [];
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            member = _ref[_i];
            _results.push("<span class='member'>" + member + "</span>");
          }
          return _results;
        })();
        $("#presented_members").html(presentMembers.join(''));
      }
      if (data.absent_members) {
        absentMembers = (function() {
          var _i, _len, _ref, _results;

          _ref = data.absent_members;
          _results = [];
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            member = _ref[_i];
            _results.push("<span class='member absent'>" + member + "</span>");
          }
          return _results;
        })();
        $("#absent_members").html(absentMembers.join(''));
      }
      date = new Date(data.date);
      return $("#time").html("" + (date.getFullYear()) + "年 " + (date.getMonth() + 1) + "月 " + (date.getDate()) + "日");
    };

    PageRenderer.prototype.renderEvents = function(events) {
      var event, html, output;

      output = (function() {
        var _i, _len, _results;

        _results = [];
        for (_i = 0, _len = events.length; _i < _len; _i++) {
          event = events[_i];
          _results.push(this.renderEvent(event));
        }
        return _results;
      }).call(this);
      html = output.join('');
      return $("#events").append(html);
    };

    PageRenderer.prototype.renderEvent = function(event) {
      var output, speaker, supplement, text;

      output = "";
      if (event.type === "speech") {
        speaker = "<div class='speaker'>" + event.speaker.full + "</div>";
        text = "<div class='text'>" + event.text + "</div>";
        if (supplement) {
          supplement = "<div class='supplement'>" + event.supplement + "</div>";
        } else {
          supplement = "";
        }
        output = "<div class='event speech'><pre>" + speaker + text + supplement + "</pre></div>";
      } else {
        text = "<div class='text'>" + event.text + "</div>";
        output = "<div class='event action'>" + text + "</div>";
      }
      return output;
    };

    return PageRenderer;

  })();

  window.PageRenderer = PageRenderer;

}).call(this);
