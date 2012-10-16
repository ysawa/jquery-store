(function() {

  (function($) {
    var jqstore;
    $.extend({
      store: {
        generate_key: function(key) {
          return "" + this.prefix + key;
        },
        get: function(key) {
          var j, value_string;
          j = jqstore;
          key = j.generate_key(key);
          if (j.local_storage_valid) {
            value_string = j.storage.getItem(key);
          } else if (j.user_data_valid) {
            j.storage.load(j.user_data_node);
            value_string = j.storage.getAttribute(key);
          } else {
            value_string = j.storage[key];
          }
          if (typeof value_string === 'undefined' || value_string === null) {
            return value_string;
          } else if (value_string === 'undefined') {
            return void 0;
          } else {
            return j.parse_json(value_string);
          }
        },
        initialize: function() {
          var test_key, value;
          this.local_storage_valid = false;
          this.user_data_valid = false;
          if (window.localStorage) {
            test_key = this.generate_key('_test');
            localStorage.setItem(test_key, 'valid');
            value = localStorage.getItem(test_key);
            if (value && value === 'valid') {
              this.local_storage_valid = true;
              this.storage = localStorage;
            }
          }
          if (!this.local_storage_valid && navigator.userAgent.toLowerCase().indexOf('msie') !== -1 && document.documentElement && document.documentElement.addBehavior) {
            this.storage = document.createElement(this.user_data_node);
            document.getElementsByTagName('head')[0].appendChild(this.storage);
            this.storage.addBehavior('#default#userData');
            this.user_data_valid = true;
          }
          if (!(this.local_storage_valid || this.user_data_valid)) {
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
          '\b': '\\b',
          '\t': '\\t',
          '\n': '\\n',
          '\f': '\\f',
          '\r': '\\r',
          '"': '\\"',
          '\\': '\\\\'
        },
        json_escape_character: function(character) {
          var j;
          j = jqstore;
          return j.json_special_characters[character] || '\\u' + ('0000' + character.charCodeAt(0).toString(16)).slice(-4);
        },
        local_storage_valid: false,
        parse_json: function(string) {
          return $.parseJSON(string);
        },
        prefix: 'js_',
        remove: function(key) {
          var j;
          j = jqstore;
          key = j.generate_key(key);
          if (j.local_storage_valid) {
            return j.storage.removeItem(key);
          } else if (j.user_data_valid) {
            j.storage.removeAttribute(key);
            return j.storage.save(j.user_data_node);
          } else {
            return delete j.storage[key];
          }
        },
        set: function(key, value) {
          var j, value_string;
          j = jqstore;
          value_string = j.stringify_json(value);
          key = j.generate_key(key);
          if (j.local_storage_valid) {
            return j.storage.setItem(key, value_string);
          } else if (j.user_data_valid) {
            j.storage.setAttribute(key, value_string);
            return j.storage.save(j.user_data_node);
          } else {
            return j.storage[key] = value_string;
          }
        },
        storage: {},
        stringify_json: function(data, root) {
          var j, string, type;
          j = jqstore;
          type = $.type(data);
          if (j.json_object) {
            return j.json_object.stringify(data);
          }
          switch (type) {
            case 'string':
              return '"' + data.replace(/[\x00-\x1f\\"]/g, j.json_escape_character) + '"';
            case 'array':
              return '[' + $.map(data, j.stringify_json) + ']';
            case 'object':
              string = [];
              $.each(data, function(key, value) {
                var key_json, value_json;
                value_json = j.stringify_json(value);
                if (typeof value_json !== 'undefined') {
                  key_json = j.stringify_json(key);
                  return string.push("" + key_json + ":" + value_json);
                }
              });
              return '{' + string + '}';
            case 'number':
            case 'boolean':
            case 'null':
              return '' + data;
            case 'date':
              return j.stringify_json_date(data);
            case 'regexp':
              return '{}';
            case 'function':
            case 'undefined':
              if (root) {
                return void 0;
              } else {
                return 'null';
              }
          }
          return data;
        },
        stringify_json_date: function(data) {
          var day, hour, milli, minute, month, second, year;
          year = data.getUTCFullYear();
          month = data.getUTCMonth() + 1;
          day = data.getUTCDate();
          hour = data.getUTCHours();
          minute = data.getUTCMinutes();
          second = data.getUTCSeconds();
          milli = data.getUTCMilliseconds();
          if (month < 10) {
            month = '0' + month;
          }
          if (day < 10) {
            day = '0' + day;
          }
          if (hour < 10) {
            hour = '0' + hour;
          }
          if (minute < 10) {
            minute = '0' + minute;
          }
          if (second < 10) {
            second = '0' + second;
          }
          if (milli < 10) {
            milli = '00' + milli;
          } else if (milli < 100) {
            milli = '0' + milli;
          }
          return "\"" + year + "-" + month + "-" + day + "T" + hour + ":" + minute + ":" + second + "." + milli + "Z\"";
        },
        user_data_valid: false,
        user_data_node: 'jquerystore'
      }
    });
    jqstore = $.store;
    return jqstore.initialize();
  })(jQuery);

}).call(this);
