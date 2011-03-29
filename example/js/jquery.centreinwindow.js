/* jQuery CentreInWindow Plugin
 * ---------------------------------------------------
 * Version 1.0 (March 2011)
 * Author: Steve Hayter (http://stevehayter.me)
 * ---------------------------------------------------
 * Centres an element in the centre of the window, both horizontally and vertically. Prevents
 * content from being positioned off the screen when the content is too large for the window.
 * Tested in IE6+, Firefox 2+, Chrome 1+, and Safari 3+.
 *
 */

(function ($) {

    $.fn.centreInWindow = function () {

        // Get the content
        var content = this;

        // Position content absolutely
        content.css({'position': 'absolute'});

        // Internal function that centres the content in the window
        function centre() {
            // Get x and y co-ordinates
            var xPosition = ($(window).width() - content.outerWidth(true)) / 2;
            var yPosition = ($(window).height() - content.outerHeight(true)) / 2;

            // Check the element doesn't off the screen (we do this so if the window is smaller
            // than the content, the content stays flush with the left of the window, rather 
            // than going beyond it).
            if (xPosition >= $('body').offset().left) {
                // Set the left position
                content.css({ 'left': xPosition + 'px' });
            }
            else {
                // Go back to normal
                content.css({ 'left': 'auto' });
            }

            // Same check for the y co-ordinates
            if (yPosition >= $('body').offset().top) {
                // Set the left position
                content.css({ 'top': yPosition + 'px' });
            }
            else {
                // Go back to normal
                content.css({ 'top': 'auto' });
            }
        }

        // First wire it up to the window resize event
        $(window).resize(function () {
            // Call the function
            centre();
        });

        // And call it so it runs immediately
        centre();

    };
})(jQuery);