jQuery(function($) {
  var Sizer = $.klass({
    initialize: function(threshold, className) {
      this.threshold = threshold;
      this.className = className;
      this.body = $('body');
      this._update();
    },
    onresize: function() {
      this._update();
    },
    _update: function() {
      if (this.body.width() > this.threshold) this.body.addClass(this.className);
      else this.body.removeClass(this.className);
    }
  });
  
  
  $(window).attach(Sizer, 1000, 'wide')
});