(function($) {
  var log = function() {
    if(window && window.console && window.console.log) {
      window.console.log(arguments);
    }
  };

  $.smooth = function(ratio, size_perc) {
    if(ratio === undefined) ratio = 16 / 9;
    if(size_perc === undefined) size_perc = 0.85;

    var canvas = $("<div class='canvas'/>").appendTo("body");
    var slides = $(".slide").appendTo(canvas);
    var current_slide;

    var w = $(window);

    var resize = function() {
      var width = w.width();

      var slide_width = width * size_perc;
      var slide_height = slide_width / ratio;
      var font_size = slide_width / 60;

      var dimensions = {
        width: slide_width + "px",
        height: slide_height + "px"
      };

      canvas.css(dimensions);

      canvas.css({
        "font-size": font_size + "px"
      });

      $("body").css("padding-top", (w.height() / 2 - slide_height * 0.52) + "px");
    };
    w.resize(resize);

    var init_slides = function() {
      slides.hide();
      slides.css({
        position: "absolute",
        width: "88%",
        margin: "4% 6% 0 6%"
      });
      canvas.css({
        overflow: "hidden",
        position: "relative"
      });
      current_slide = slides.first().show();
      log("Current slide:", current_slide);
    };

    var move_to = (function() {
        var _blocked = false;

        return function(next_slide, direction) {
          if(_blocked) return;
          _blocked = true;

          if(direction == "left") {
            var next_init = canvas.width() + "px";
            var current_to = "-" + canvas.width() + "px";
          } else if(direction == "right") {
            var next_init = "-" + canvas.width() + "px";
            var current_to = canvas.width() + "px";
          }

          next_slide.css('left', next_init).show();

          current_slide.animate({
            left: current_to
          }, "slow", function() {
            $(this).hide();
            current_slide = next_slide;

            _blocked = false;
          });

          next_slide.animate({
            left: "0px"
          }, "slow");
        };
    })();

    var next_slide = function() {
      var next = current_slide.next();
      if(next.size() > 0) {
        move_to(next, "left");
      }
    };

    var prev_slide = function() {
      var prev = current_slide.prev();
      if(prev.size() > 0) {
        move_to(prev, "right");
      }
    };

    var first_slide = function() {
      if(current_slide[0] != slides.first()[0]){
        move_to(slides.first(), "right");
      }
    };

    var last_slide = function() {
      if(current_slide[0] != slides.last()[0]){
        move_to(slides.last(), "left");
      }
    };


    // KEY CONTROL
    (function() {
      var K_NEXT = [
        39, // right
        40, // down
        34, // pagedown
        68, // D
        32  // space
      ];
      var K_PREV = [
        37, // left
        38, // up
        33, // pageup
        65  // A
      ];
      var K_FIRST = [
        36  // home
      ];
      var K_LAST = [
        35  // end
      ];
      var key_in = function(k, vals) {
        for(var i = 0; i < vals.length; i++) {
          if(vals[i] === k) return true;
        }
        return false;
      };
      var inp = $("<input type='text'/>").css({
        position: "absolute",
        top: "-200px"
      }).prependTo($("body")).focus().keydown(function(evt) {
        // KEYDOWN
        if(key_in(evt.keyCode, K_NEXT)) {
          next_slide();
        } else if(key_in(evt.keyCode, K_PREV)) {
          prev_slide();
        } else if(key_in(evt.keyCode, K_FIRST)) {
          first_slide();
        } else if(key_in(evt.keyCode, K_LAST)) {
          last_slide();
        }
        log("Pressed:", evt.keyCode);
      }).blur(function(e) {
        $(this).focus();
      });
    })();

    // initialize the slides
    init_slides();
    resize();
    
    log("smoothified!");
  };
})(jQuery);
