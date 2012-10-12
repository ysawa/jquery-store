(function() {

  (function($) {
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
            return this.parse_json(value_string);
          }
        },
        initialize: function() {
          var test_key, value;
          this.storage_valid = false;
          if (typeof localStorage !== 'undefined') {
            test_key = this.generate_key('_test');
            localStorage.setItem(test_key, 'valid');
            value = localStorage.getItem(test_key);
            if (value && value === 'valid') {
              this.storage_valid = true;
            }
          }
          if (this.storage_valid) {
            this.storage = localStorage;
          } else {
            this.storage = {};
          }
          if (window.JSON && window.JSON.stringify) {
            return this.json_object = window.JSON;
          } else {
            return this.json_object = null;
          }
        },
        json_object: null,
        json_special_characters: {
          "\b": "\\b",
          "\t": "\\t",
          "\n": "\\n",
          "\f": "\\f",
          "\r": "\\r",
          "\"": "\\\"",
          "\\": "\\\\"
        },
        json_escape_character: function(character) {
          return this.json_special_characters[character] || "\\u" + ("0000" + character.charCodeAt(0).toString(16)).slice(-4);
        },
        parse_json: $.parseJSON,
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
          value_string = this.stringify_json(value);
          key = this.generate_key(key);
          if (this.storage_valid) {
            return this.storage.setItem(key, value_string);
          } else {
            return this.storage[key] = value_string;
          }
        },
        storage: {},
        storage_valid: false,
        stringify_json: function(data) {
          var day, hour, json_escape_character, milli, minute, month, second, string, stringify_json, that, year;
          if (this.json_object) {
            return this.json_object.stringify(data);
          }
          that = this;
          switch ($.type(data)) {
            case "string":
              json_escape_character = function(string) {
                return that.json_escape_character(string);
              };
              return "\"" + data.replace(/[\x00-\x1f\\"]/g, json_escape_character) + "\"";
            case "array":
              stringify_json = function(object) {
                return that.stringify_json(object);
              };
              return "[" + $.map(data, stringify_json) + "]";
            case "object":
              string = [];
              stringify_json = function(object) {
                return that.stringify_json(object);
              };
              $.each(data, function(key, value) {
                var json;
                json = stringify_json(value);
                if (json) {
                  return string.push(stringify_json(key) + ":" + json);
                }
              });
              return "{" + string + "}";
            case "number":
            case "boolean":
              return "" + data;
            case "date":
              year = data.getUTCFullYear();
              month = data.getUTCMonth() + 1;
              day = data.getUTCDate();
              hour = data.getUTCHours();
              minute = data.getUTCMinutes();
              second = data.getUTCSeconds();
              milli = data.getUTCMilliseconds();
              if (month < 10) {
                month = "0" + month;
              }
              if (day < 10) {
                day = "0" + day;
              }
              if (hour < 10) {
                hour = "0" + hour;
              }
              if (minute < 10) {
                minute = "0" + minute;
              }
              if (second < 10) {
                second = "0" + second;
              }
              return "\"" + year + "-" + month + "-" + day + "T" + hour + ":" + minute + ":" + second + "." + milli + "Z\"";
            case "undefined":
            case "null":
              return "null";
          }
          return data;
        }
      }
    });
    return $.store.initialize();
  })(jQuery);

}).call(this);
