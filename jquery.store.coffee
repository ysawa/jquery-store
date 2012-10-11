# jQuery Store

(($) ->
  $.fn.extend
    store:
      get: (key) ->
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
          @storage = {}
          @storage_valid = false
        else
          # localStorage is valid
          @storage = localStorage
          @storage_valid = true
      remove: (key) ->
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
        if @storage_valid
          @storage.setItem(key, wrap_string)
        else
          @storage[key] = wrap_string
      storage: {}
      storage_valid: false
  $.store.initialize()
) jQuery
