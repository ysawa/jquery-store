(($) ->
  $.fn.extend
    store:
      get: (key) ->
        value_string = @storage.getItem(key)
        if typeof value_string == 'undefined' or value_string == null
          value_string
        else
          JSON.parse(value_string)
        end
      remove: (key) ->
        @storage.removeItem(key)
      remove_all: ->
        @storage.clear()
      set: (key, value) ->
        value_string = JSON.stringify(value)
        @storage.setItem(key, value_string)
      storage: localStorage

) jQuery
