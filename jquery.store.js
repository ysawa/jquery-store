(function() {

  (function($) {
    $.extend({
      store: {
        generate_key: function(key) {
          return "" + this.prefix + key;
        },
        get: function(key) {
          var wrap, wrap_string;
          key = this.generate_key(key);
          wrap_string;

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
          var test_key, value;
          if (typeof localStorage === 'undefined') {
            this.storage_valid = false;
          } else {
            test_key = 'jqstore__test';
            localStorage.setItem(test_key, 'valid');
            value = localStorage.getItem(test_key);
            if (value && value === 'valid') {
              this.storage_valid = true;
            } else {
              this.storage_valid = false;
            }
          }
          if (this.storage_valid) {
            return this.storage = {};
          } else {
            return this.storage = localStorage;
          }
        },
        prefix: 'jqstore_',
        remove: function(key) {
          key = this.generate_key(key);
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
          key = this.generate_key(key);
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
