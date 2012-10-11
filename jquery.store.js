(function() {

  (function($) {
    return $.fn.extend({
      store: {
        get: function(key) {
          var value_string;
          value_string = this.storage.getItem(key);
          if (typeof value_string === 'undefined' || value_string === null) {
            value_string;

          } else {
            JSON.parse(value_string);
          }
          return end;
        },
        remove: function(key) {
          return this.storage.removeItem(key);
        },
        remove_all: function() {
          return this.storage.clear();
        },
        set: function(key, value) {
          var value_string;
          value_string = JSON.stringify(value);
          return this.storage.setItem(key, value_string);
        },
        storage: localStorage
      }
    });
  })(jQuery);

}).call(this);
