# jQuery Store
#
# jQuery Store can store almost all type of objects.
#
# In the codes, JSON.parse and JSON.stringify used.
# I recommend to insert this code in your html:
# <!--[if lt IE 8]>
# <script src="./JSON-js/json2.js"></script>
# <![endif]-->

(($) ->
  $.fn.extend
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
          wrap = JSON.parse(wrap_string)
          wrap[0]
        end
      initialize: ->
        if typeof localStorage == 'undefined'
          # localStorage is invalid
          @storage_valid = false
        else
          test_key = 'jqstore__test'
          localStorage.setItem(test_key, 'valid')
          value = localStorage.getItem(test_key)
          if value and value == 'valid'
            # localStorage is valid
            @storage_valid = true
          else
            # localStorage is invalid
            @storage_valid = false
        if @storage_valid
          # if localStorage is invalid, use just a hash
          @storage = {}
        else
          @storage = localStorage
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
        wrap_string = JSON.stringify(wrap)
        key = @generate_key(key)
        if @storage_valid
          @storage.setItem(key, wrap_string)
        else
          @storage[key] = wrap_string
      storage: {}
      storage_valid: false
  $.store.initialize()
) jQuery
