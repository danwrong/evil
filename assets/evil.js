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
  
  var TemplateReorder = $.klass({
    initialize: function() {
      this.element.tableDnD({
        onDrop: $.bind(this._onDrop, this),
        onDragClass: 'dragging'
      });
    },
    _onDrop: function() {
      var data = $.tableDnD.serialize();
      
      $.post('/admin/templates/reorder', data);
      
      this._restripe();
    },
    _restripe: function() {
      this.element.find('tbody tr:odd').addClass('alt');
      this.element.find('tbody tr:even').removeClass('alt');
    }
  })
  
  
  $(window).attach(Sizer, 1000, 'wide');
  $('#templates').attach(TemplateReorder);
});