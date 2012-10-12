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
        wrap_string
        if @storage_valid
          wrap_string = @storage.getItem(key)
        else
          wrap_string = @storage[key]

        if typeof wrap_string == 'undefined' or wrap_string == null
          wrap_string
        else
          wrap = $.parseJSON(wrap_string)
          wrap[0]
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
        wrap = [value]
        wrap_string = $.stringifyJSON(wrap)
        key = @generate_key(key)
        if @storage_valid
          @storage.setItem(key, wrap_string)
        else
          @storage[key] = wrap_string
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
      data

  $.store.initialize()
) jQuery
