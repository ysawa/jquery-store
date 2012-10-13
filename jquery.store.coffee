# jQuery Store

(($) ->
  $.extend
    # jqstore = $.store below
    store:
      generate_key: (key) ->
        "#{@prefix}#{key}"
      get: (key) ->
        that = jqstore
        key = that.generate_key(key)
        value_string
        if that.storage_valid
          value_string = that.storage.getItem(key)
        else
          value_string = that.storage[key]

        if typeof value_string == 'undefined' or value_string == null
          value_string
        else if value_string == 'undefined'
          undefined
        else
          that.parse_json(value_string)
      initialize: ->
        @storage_valid = false
        unless typeof localStorage == 'undefined'
          test_key = @generate_key('_test')
          localStorage.setItem(test_key, 'valid')
          value = localStorage.getItem(test_key)
          if value and value == 'valid'
            # localStorage is available
            @storage_valid = true
        if @storage_valid
          @storage = localStorage
        else
          # if localStorage is NOT available, use just a hash
          @storage = {}
        if window.JSON and window.JSON.stringify
          @json_object = window.JSON
        else
          @json_object = null
      json_object: null
      json_special_characters:
        '\b': '\\b'
        '\t': '\\t'
        '\n': '\\n'
        '\f': '\\f'
        '\r': '\\r'
        '"': '\\"'
        '\\': '\\\\'
      json_escape_character: (character) ->
        that = jqstore
        that.json_special_characters[character] or
          '\\u' + ('0000' + character.charCodeAt(0).toString(16)).slice(-4)
      parse_json: (string) ->
        $.parseJSON(string)
      prefix: 'js_'
      remove: (key) ->
        that = jqstore
        key = that.generate_key(key)
        if that.storage_valid
          that.storage.removeItem(key)
        else
          delete that.storage[key]
      remove_all: ->
        that = jqstore
        if that.storage_valid
          that.storage.clear()
        else
          that.storage = {}
      set: (key, value) ->
        that = jqstore
        value_string = that.stringify_json(value)
        key = that.generate_key(key)
        if that.storage_valid
          that.storage.setItem(key, value_string)
        else
          that.storage[key] = value_string
      storage: {}
      storage_valid: false
      stringify_json: (data) ->
        that = jqstore
        return that.json_object.stringify(data) if that.json_object
        switch $.type(data)
          when 'string'
            return '"' + data.replace(/[\x00-\x1f\\"]/g, that.json_escape_character) + '"'
          when 'array'
            return '[' + $.map(data, that.stringify_json) + ']'
          when 'object'
            string = []
            $.each data, (key, value) ->
              value_json = that.stringify_json(value)
              unless typeof value_json == 'undefined'
                key_json = that.stringify_json(key)
                string.push "#{key_json}:#{value_json}"
            return '{' + string + '}'
          when 'number', 'boolean'
            return '' + data
          when 'date'
            return that.stringify_json_date(data)
          when 'regexp'
            return '{}'
          when 'function', 'undefined'
            return undefined
          when 'null'
            return 'null'
        data
      stringify_json_date: (data) ->
        year = data.getUTCFullYear()
        month = data.getUTCMonth() + 1
        day = data.getUTCDate()
        hour = data.getUTCHours()
        minute = data.getUTCMinutes()
        second = data.getUTCSeconds()
        milli = data.getUTCMilliseconds()
        month = '0' + month if month < 10
        day = '0' + day if day < 10
        hour = '0' + hour if hour < 10
        minute = '0' + minute if minute < 10
        second = '0' + second if second < 10
        "\"#{year}-#{month}-#{day}T#{hour}:#{minute}:#{second}.#{milli}Z\""

  jqstore = $.store
  jqstore.initialize()
) jQuery
