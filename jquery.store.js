(function() {

  (function($) {
    var jqstore;
    $.extend({
      store: {
        generate_key: function(key) {
          return "" + this.prefix + key;
        },
        get: function(key) {
          var that, value_string;
          that = jqstore;
          key = that.generate_key(key);
          value_string;

          if (that.storage_valid) {
            value_string = that.storage.getItem(key);
          } else {
            value_string = that.storage[key];
          }
          if (typeof value_string === 'undefined' || value_string === null) {
            return value_string;
          } else if (value_string === 'undefined') {
            return void 0;
          } else {
            return that.parse_json(value_string);
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
          '\b': '\\b',
          '\t': '\\t',
          '\n': '\\n',
          '\f': '\\f',
          '\r': '\\r',
          '"': '\\"',
          '\\': '\\\\'
        },
        json_escape_character: function(character) {
          var that;
          that = jqstore;
          return that.json_special_characters[character] || '\\u' + ('0000' + character.charCodeAt(0).toString(16)).slice(-4);
        },
        parse_json: function(string) {
          return $.parseJSON(string);
        },
        prefix: 'jqstore_',
        remove: function(key) {
          var that;
          that = jqstore;
          key = that.generate_key(key);
          if (that.storage_valid) {
            return that.storage.removeItem(key);
          } else {
            return delete that.storage[key];
          }
        },
        remove_all: function() {
          var that;
          that = jqstore;
          if (that.storage_valid) {
            return that.storage.clear();
          } else {
            return that.storage = {};
          }
        },
        set: function(key, value) {
          var that, value_string;
          that = jqstore;
          value_string = that.stringify_json(value);
          key = that.generate_key(key);
          if (that.storage_valid) {
            return that.storage.setItem(key, value_string);
          } else {
            return that.storage[key] = value_string;
          }
        },
        storage: {},
        storage_valid: false,
        stringify_json: function(data) {
          var string, that;
          that = jqstore;
          if (that.json_object) {
            return that.json_object.stringify(data);
          }
          switch ($.type(data)) {
            case 'string':
              return '"' + data.replace(/[\x00-\x1f\\"]/g, that.json_escape_character) + '"';
            case 'array':
              return '[' + $.map(data, that.stringify_json) + ']';
            case 'object':
              string = [];
              $.each(data, function(key, value) {
                var key_json, value_json;
                value_json = that.stringify_json(value);
                if (typeof value_json !== 'undefined') {
                  key_json = that.stringify_json(key);
                  return string.push("" + key_json + ":" + value_json);
                }
              });
              return '{' + string + '}';
            case 'number':
            case 'boolean':
              return '' + data;
            case 'date':
              return that.stringify_json_date(data);
            case 'regexp':
              return '{}';
            case 'function':
            case 'undefined':
              return void 0;
            case 'null':
              return 'null';
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
          return "\"" + year + "-" + month + "-" + day + "T" + hour + ":" + minute + ":" + second + "." + milli + "Z\"";
        }
      }
    });
    jqstore = $.store;
    return jqstore.initialize();
  })(jQuery);

}).call(this);
