# jQuery Store
#
# jQuery Store can store almost all type of objects.

(($) ->
  special_chars =
    "\b": "\\b"
    "\t": "\\t"
    "\n": "\\n"
    "\f": "\\f"
    "\r": "\\r"
    "\"": "\\\""
    "\\": "\\\\"

  escape_char = (char) ->
    special_chars[char] or "\\u" + ("0000" + chr.charCodeAt(0).toString(16)).slice(-4)

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
          $.parseJSON(value_string)
      initialize: ->
        @storage_valid = false
        unless typeof localStorage == 'undefined'
          test_key = 'jqstore__test'
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
        value_string = $.stringifyJSON(value)
        key = @generate_key(key)
        if @storage_valid
          @storage.setItem(key, value_string)
        else
          @storage[key] = value_string
      storage: {}
      storage_valid: false
    stringifyJSON: (data) ->
      return window.JSON.stringify(data) if window.JSON and window.JSON.stringify
      switch $.type(data)
        when "string"
          return "\"" + data.replace(/[\x00-\x1f\\"]/g, escape_char) + "\""
        when "array"
          return "[" + $.map(data, $.stringifyJSON) + "]"
        when "object"
          string = []
          $.each data, (key, value) ->
            json = $.stringifyJSON(value)
            string.push $.stringifyJSON(key) + ":" + json if json
          return "{" + string + "}"
        when "number", "boolean"
          return "" + data
        when "undefined", "null"
          return "null"
        when "date"
          # TODO use ISO's date format and wrap it with double quotes
      data

  $.store.initialize()
) jQuery
