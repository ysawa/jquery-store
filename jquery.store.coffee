# jQuery Store
#
# jQuery Store can store almost all type of objects.

(($) ->
  $.extend
    store:
      generate_key: (key) ->
        "#{@prefix}#{key}"
      get: (key) ->
        key = @generate_key(key)
        value_string
        if @storage_valid
          value_string = @storage.getItem(key)
        else
          value_string = @storage[key]

        if typeof value_string == 'undefined' or value_string == null
          value_string
        else
          @parse_json(value_string)
      initialize: ->
        @storage_valid = false
        unless typeof localStorage == 'undefined'
          test_key = @generate_key('_test')
          localStorage.setItem(test_key, 'valid')
          value = localStorage.getItem(test_key)
          if value and value == 'valid'
            # localStorage is valid
            @storage_valid = true
        if @storage_valid
          # if localStorage is invalid, use just a hash
          @storage = localStorage
        else
          @storage = {}
        if window.JSON and window.JSON.stringify
          @json_object = window.JSON
        else
          @json_object = null
      json_object: null
      json_special_characters:
        "\b": "\\b"
        "\t": "\\t"
        "\n": "\\n"
        "\f": "\\f"
        "\r": "\\r"
        "\"": "\\\""
        "\\": "\\\\"
      json_escape_character: (character) ->
        @json_special_characters[character] or
          "\\u" + ("0000" + character.charCodeAt(0).toString(16)).slice(-4)
      parse_json: $.parseJSON
      prefix: 'jqstore_'
      remove: (key) ->
        key = @generate_key(key)
        if @storage_valid
          @storage.removeItem(key)
        else
          delete @storage[key]
      remove_all: ->
        if @storage_valid
          @storage.clear()
        else
          @storage = {}
      set: (key, value) ->
        value_string = @stringify_json(value)
        key = @generate_key(key)
        if @storage_valid
          @storage.setItem(key, value_string)
        else
          @storage[key] = value_string
      storage: {}
      storage_valid: false
      stringify_json: (data) ->
        return @json_object.stringify(data) if @json_object
        that = @
        switch $.type(data)
          when "string"
            json_escape_character = (string) ->
              that.json_escape_character(string)
            return "\"" + data.replace(/[\x00-\x1f\\"]/g, json_escape_character) + "\""
          when "array"
            stringify_json = (object) ->
              that.stringify_json(object)
            return "[" + $.map(data, stringify_json) + "]"
          when "object"
            string = []
            stringify_json = (object) ->
              that.stringify_json(object)
            $.each data, (key, value) ->
              json = stringify_json(value)
              string.push stringify_json(key) + ":" + json if json
            return "{" + string + "}"
          when "number", "boolean"
            return "" + data
          when "date"
            year = data.getUTCFullYear()
            month = data.getUTCMonth() + 1
            day = data.getUTCDate()
            hour = data.getUTCHours()
            minute = data.getUTCMinutes()
            second = data.getUTCSeconds()
            milli = data.getUTCMilliseconds()
            month = "0" + month if month < 10
            day = "0" + day if day < 10
            hour = "0" + hour if hour < 10
            minute = "0" + minute if minute < 10
            second = "0" + second if second < 10
            return "\"#{year}-#{month}-#{day}T#{hour}:#{minute}:#{second}.#{milli}Z\""
          when "undefined", "null"
            return "null"
        data

  $.store.initialize()
) jQuery
