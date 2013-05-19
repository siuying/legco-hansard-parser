(function() {
  var PageRenderer,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

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
      console.log("render data:");
      this.renderHeader(data);
      return this.renderEvents(data.events);
    };

    PageRenderer.prototype.renderHeader = function(data) {
      var absentMembers, member, presentMembers;

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
      $("#presented_members").html(presentMembers.join(''));
      return $("#absent_members").html(absentMembers.join(''));
    };

    PageRenderer.prototype.renderEvents = function(events) {
      var event, html, output;

      console.log('render events');
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
      var output, speaker, text;

      output = "";
      if (event.type === "speech") {
        speaker = "<div class='speaker'>" + event.speaker.full + "</div>";
        text = "<div class='text'>" + event.text + "</div>";
        output = "<div class='event speech'><pre>" + speaker + text + "</pre></div>";
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
