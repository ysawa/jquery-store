(function() {

  (function($) {
    var escape_char, special_chars;
    special_chars = {
      "\b": "\\b",
      "\t": "\\t",
      "\n": "\\n",
      "\f": "\\f",
      "\r": "\\r",
      "\"": "\\\"",
      "\\": "\\\\"
    };
    escape_char = function(char) {
      return special_chars[char] || "\\u" + ("0000" + chr.charCodeAt(0).toString(16)).slice(-4);
    };
    $.extend({
      store: {
        generate_key: function(key) {
          return "" + this.prefix + key;
        },
        get: function(key) {
          var value_string;
          key = this.generate_key(key);
          value_string;

          if (this.storage_valid) {
            value_string = this.storage.getItem(key);
          } else {
            value_string = this.storage[key];
          }
          if (typeof value_string === 'undefined' || value_string === null) {
            return value_string;
          } else {
            return $.parseJSON(value_string);
          }
        },
        initialize: function() {
          var test_key, value;
          this.storage_valid = false;
          if (typeof localStorage !== 'undefined') {
            test_key = 'jqstore__test';
            localStorage.setItem(test_key, 'valid');
            value = localStorage.getItem(test_key);
            if (value && value === 'valid') {
              this.storage_valid = true;
            }
          }
          if (this.storage_valid) {
            return this.storage = localStorage;
          } else {
            return this.storage = {};
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
          var value_string;
          value_string = $.stringifyJSON(value);
          key = this.generate_key(key);
          if (this.storage_valid) {
            return this.storage.setItem(key, value_string);
          } else {
            return this.storage[key] = value_string;
          }
        },
        storage: {},
        storage_valid: false
      },
      stringifyJSON: function(data) {
        var string;
        if (window.JSON && window.JSON.stringify) {
          return window.JSON.stringify(data);
        }
        switch ($.type(data)) {
          case "string":
            return "\"" + data.replace(/[\x00-\x1f\\"]/g, escape_char) + "\"";
          case "array":
            return "[" + $.map(data, $.stringifyJSON) + "]";
          case "object":
            string = [];
            $.each(data, function(key, value) {
              var json;
              json = $.stringifyJSON(value);
              if (json) {
                return string.push($.stringifyJSON(key) + ":" + json);
              }
            });
            return "{" + string + "}";
          case "number":
          case "boolean":
            return "" + data;
          case "undefined":
          case "null":
            return "null";
          case "date":
            return "" + data.getTime();
        }
        return data;
      }
    });
    return $.store.initialize();
  })(jQuery);

}).call(this);
