# jQuery Store

(($) ->
  $.extend
    # jqstore = $.store below
    store:
      generate_key: (key) ->
        "#{@prefix}#{key}"
      get: (key) ->
        j = jqstore
        key = j.generate_key(key)
        if j.local_storage_valid
          value_string = j.storage.getItem(key)
        else if j.user_data_valid
          j.storage.load(j.user_data_node)
          value_string = j.storage.getAttribute(key)
        else
          value_string = j.storage[key]

        if typeof value_string == 'undefined' or value_string == null
          value_string
        else if value_string == 'undefined'
          undefined
        else
          j.parse_json(value_string)
      initialize: ->
        @local_storage_valid = false
        @user_data_valid = false
        if window.localStorage
          test_key = @generate_key('_test')
          localStorage.setItem(test_key, 'valid')
          value = localStorage.getItem(test_key)
          if value and value == 'valid'
            # localStorage is available
            @local_storage_valid = true
            @storage = localStorage
        if !@local_storage_valid and
            navigator.userAgent.toLowerCase().indexOf('msie') != -1 and
            document.documentElement and
            document.documentElement.addBehavior
          @storage = document.createElement(@user_data_node)
          document.getElementsByTagName('head')[0].appendChild(@storage)
          @storage.addBehavior('#default#userData')
          @user_data_valid = true
        unless @local_storage_valid or @user_data_valid
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
        j = jqstore
        j.json_special_characters[character] or
          '\\u' + ('0000' + character.charCodeAt(0).toString(16)).slice(-4)
      local_storage_valid: false
      parse_json: (string) ->
        $.parseJSON(string)
      prefix: 'js_'
      remove: (key) ->
        j = jqstore
        key = j.generate_key(key)
        if j.local_storage_valid
          j.storage.removeItem(key)
        else if j.user_data_valid
          j.storage.removeAttribute(key)
          j.storage.save(j.user_data_node)
        else
          delete j.storage[key]
      set: (key, value) ->
        j = jqstore
        value_string = j.stringify_json(value)
        key = j.generate_key(key)
        if j.local_storage_valid
          j.storage.setItem(key, value_string)
        else if j.user_data_valid
          j.storage.setAttribute(key, value_string)
          j.storage.save(j.user_data_node)
        else
          j.storage[key] = value_string
      storage: {}
      stringify_json: (data, root) ->
        j = jqstore
        type = $.type(data)
        return j.json_object.stringify(data) if j.json_object
        switch type
          when 'string'
            return '"' + data.replace(/[\x00-\x1f\\"]/g, j.json_escape_character) + '"'
          when 'array'
            return '[' + $.map(data, j.stringify_json) + ']'
          when 'object'
            string = []
            $.each data, (key, value) ->
              value_json = j.stringify_json(value)
              unless typeof value_json == 'undefined'
                key_json = j.stringify_json(key)
                string.push "#{key_json}:#{value_json}"
            return '{' + string + '}'
          when 'number', 'boolean', 'null'
            return '' + data
          when 'date'
            return j.stringify_json_date(data)
          when 'regexp'
            return '{}'
          when 'function', 'undefined'
            if root
              return undefined
            else
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
        if milli < 10
          milli = '00' + milli
        else if milli < 100
          milli = '0' + milli
        "\"#{year}-#{month}-#{day}T#{hour}:#{minute}:#{second}.#{milli}Z\""
      user_data_valid: false
      user_data_node: 'jquerystore'

  jqstore = $.store
  jqstore.initialize()
) jQuery
