(function() {

  (function($) {
    $.fn.extend({
      store: {
        get: function(key) {
          wrap_string;

          var wrap, wrap_string;
          if (this.storage_valid) {
            wrap_string = this.storage.getItem(key);
          } else {
            wrap_string = this.storage[key];
          }
          if (typeof wrap_string === 'undefined' || wrap_string === null) {
            wrap_string;

          } else {
            wrap = JSON.parse(wrap_string);
            wrap[0];
          }
          return end;
        },
        initialize: function() {
          if (typeof localStorage === 'undefined') {
            this.storage = {};
            return this.storage_valid = false;
          } else {
            this.storage = localStorage;
            return this.storage_valid = true;
          }
        },
        remove: function(key) {
          if (this.storage_valid) {
            return this.storage.removeItem(key);
          } else {
            return delete this.storage[key];
          }
        },
        remove_all: function() {
          if (this.storage_valid) {
            return this.storage.clear();
          } else {
            return this.storage = {};
          }
        },
        set: function(key, value) {
          var wrap, wrap_string;
          wrap = [value];
          wrap_string = JSON.stringify(wrap);
          if (this.storage_valid) {
            return this.storage.setItem(key, wrap_string);
          } else {
            return this.storage[key] = wrap_string;
          }
        },
        storage: {},
        storage_valid: false
      }
    });
    return $.store.initialize();
  })(jQuery);

}).call(this);
