describe '$.store', ->
  beforeEach ->
    if window.localStorage
      window.localStorage.clear()
    $.store.initialize()

  if window.localStorage
    describe 'with localStorage and JSON', ->
      describe '.storage', ->
        it 'should be window.localStorage', ->
          expect($.store.local_storage_valid).toEqual true

      describe '.json_object', ->
        it 'should be window.JSON', ->
          expect($.store.json_object).toEqual window.JSON

      describe 'can save and load', ->
        it 'string', ->
          $.store.set('key', 'value')
          expect($.store.get('key')).toEqual 'value'

        it 'number', ->
          $.store.set('key', 1)
          expect($.store.get('key')).toEqual 1
          $.store.set('key', 1.23)
          expect($.store.get('key')).toEqual 1.23
          $.store.set('key', -1.23)
          expect($.store.get('key')).toEqual -1.23

        it 'boolean', ->
          $.store.set('key', true)
          expect($.store.get('key')).toEqual true
          $.store.set('key', false)
          expect($.store.get('key')).toEqual false

        it 'array', ->
          $.store.set('key', [1,2,true,'string'])
          expect($.store.get('key')).toEqual [1,2,true,'string']

        it 'object(hash)', ->
          $.store.set('key', {a:1,b:2,c:true,d:'string'})
          expect($.store.get('key')).toEqual {a:1,b:2,c:true,d:'string'}

      describe 'can save but cannot load expected', ->
        it 'date', ->
          $.store.set('key', new Date(2012, 11, 31, 23, 9, 59))
          expect($.store.get('key')).toMatch /^2012-12-31T14:09:59(|.000)Z$/
          $.store.set('key', new Date(1999, 1, 2, 3, 4, 5, 67))
          expect($.store.get('key')).toMatch /^1999-02-01T18:04:05(|.067)Z$/
          $.store.set('key', new Date(1999, 1, 2, 3, 4, 5, 678))
          expect($.store.get('key')).toMatch /^1999-02-01T18:04:05(|.678)Z$/

        it 'regexp', ->
          $.store.set('key', /regexp/)
          expect($.store.get('key')).toEqual {}
          $.store.set('key', [/regexp/])
          expect($.store.get('key')).toEqual [{}]

        it 'function', ->
          $.store.set('key', () ->)
          expect($.store.get('key')).toEqual undefined
          $.store.set('key', [() ->])
          expect($.store.get('key')).toEqual [null]

        it 'null', ->
          $.store.set('key', null)
          expect($.store.get('key')).toEqual null
          $.store.set('key', [null])
          expect($.store.get('key')).toEqual [null]

        it 'undefined', ->
          $.store.set('key', undefined)
          expect($.store.get('key')).toEqual undefined
          $.store.set('key', [undefined])
          expect($.store.get('key')).toEqual [null]

      describe '.remove', ->
        it 'can remove saved object', ->
          $.store.set('key', 'value')
          expect($.store.get('key')).toEqual 'value'
          $.store.remove('key')
          expect($.store.get('key')).toEqual undefined

    describe 'with localStorage and without JSON', ->
      beforeEach ->
        $.store.json_object = null

      describe '.storage', ->
        it 'should be window.localStorage', ->
          expect($.store.local_storage_valid).toEqual true

      describe '.json_object', ->
        it 'should not be window.JSON', ->
          expect($.store.json_object).toEqual null

      describe 'can save and load', ->
        it 'string', ->
          $.store.set('key', 'value')
          expect($.store.get('key')).toEqual 'value'

        it 'number', ->
          $.store.set('key', 1)
          expect($.store.get('key')).toEqual 1
          $.store.set('key', 1.23)
          expect($.store.get('key')).toEqual 1.23
          $.store.set('key', -1.23)
          expect($.store.get('key')).toEqual -1.23

        it 'boolean', ->
          $.store.set('key', true)
          expect($.store.get('key')).toEqual true
          $.store.set('key', false)
          expect($.store.get('key')).toEqual false

        it 'array', ->
          $.store.set('key', [1,2,true,'string'])
          expect($.store.get('key')).toEqual [1,2,true,'string']

        it 'object(hash)', ->
          $.store.set('key', {a:1,b:2,c:true,d:'string'})
          expect($.store.get('key')).toEqual {a:1,b:2,c:true,d:'string'}

      describe 'can save but cannot load expected', ->
        it 'date', ->
          $.store.set('key', new Date(2012, 11, 31, 23, 9, 59))
          expect($.store.get('key')).toMatch /^2012-12-31T14:09:59(|.000)Z$/
          $.store.set('key', new Date(1999, 1, 2, 3, 4, 5, 67))
          expect($.store.get('key')).toMatch /^1999-02-01T18:04:05(|.067)Z$/
          $.store.set('key', new Date(1999, 1, 2, 3, 4, 5, 678))
          expect($.store.get('key')).toMatch /^1999-02-01T18:04:05(|.678)Z$/

        it 'regexp', ->
          $.store.set('key', /regexp/)
          expect($.store.get('key')).toEqual {}
          $.store.set('key', [/regexp/])
          expect($.store.get('key')).toEqual [{}]

        it 'function', ->
          $.store.set('key', () ->)
          expect($.store.get('key')).toEqual undefined
          $.store.set('key', [() ->])
          expect($.store.get('key')).toEqual [null]

        it 'null', ->
          $.store.set('key', null)
          expect($.store.get('key')).toEqual null
          $.store.set('key', [null])
          expect($.store.get('key')).toEqual [null]

        it 'undefined', ->
          $.store.set('key', undefined)
          expect($.store.get('key')).toEqual undefined
          $.store.set('key', [undefined])
          expect($.store.get('key')).toEqual [null]

      describe '.remove', ->
        it 'can remove saved object', ->
          $.store.set('key', 'value')
          expect($.store.get('key')).toEqual 'value'
          $.store.remove('key')
          expect($.store.get('key')).toEqual undefined

    describe 'without localStorage and with JSON', ->
      beforeEach ->
        $.store.storage = {}
        $.store.local_storage_valid = false

      describe '.storage', ->
        it 'should not be window.localStorage', ->
          expect($.store.storage).toEqual {}

      describe '.json_object', ->
        it 'should be window.JSON', ->
          expect($.store.json_object).toEqual window.JSON

      describe 'can save and load', ->
        it 'string', ->
          $.store.set('key', 'value')
          expect($.store.get('key')).toEqual 'value'

        it 'number', ->
          $.store.set('key', 1)
          expect($.store.get('key')).toEqual 1
          $.store.set('key', 1.23)
          expect($.store.get('key')).toEqual 1.23
          $.store.set('key', -1.23)
          expect($.store.get('key')).toEqual -1.23

        it 'boolean', ->
          $.store.set('key', true)
          expect($.store.get('key')).toEqual true
          $.store.set('key', false)
          expect($.store.get('key')).toEqual false

        it 'array', ->
          $.store.set('key', [1,2,true,'string'])
          expect($.store.get('key')).toEqual [1,2,true,'string']

        it 'object(hash)', ->
          $.store.set('key', {a:1,b:2,c:true,d:'string'})
          expect($.store.get('key')).toEqual {a:1,b:2,c:true,d:'string'}

      describe 'can save but cannot load expected', ->
        it 'date', ->
          $.store.set('key', new Date(2012, 11, 31, 23, 9, 59))
          expect($.store.get('key')).toMatch /^2012-12-31T14:09:59(|.000)Z$/
          $.store.set('key', new Date(1999, 1, 2, 3, 4, 5, 67))
          expect($.store.get('key')).toMatch /^1999-02-01T18:04:05(|.067)Z$/
          $.store.set('key', new Date(1999, 1, 2, 3, 4, 5, 678))
          expect($.store.get('key')).toMatch /^1999-02-01T18:04:05(|.678)Z$/

        it 'regexp', ->
          $.store.set('key', /regexp/)
          expect($.store.get('key')).toEqual {}
          $.store.set('key', [/regexp/])
          expect($.store.get('key')).toEqual [{}]

        it 'function', ->
          $.store.set('key', () ->)
          expect($.store.get('key')).toEqual undefined
          $.store.set('key', [() ->])
          expect($.store.get('key')).toEqual [null]

        it 'null', ->
          $.store.set('key', null)
          expect($.store.get('key')).toEqual null
          $.store.set('key', [null])
          expect($.store.get('key')).toEqual [null]

        it 'undefined', ->
          $.store.set('key', undefined)
          expect($.store.get('key')).toEqual undefined
          $.store.set('key', [undefined])
          expect($.store.get('key')).toEqual [null]

      describe '.remove', ->
        it 'can remove saved object', ->
          $.store.set('key', 'value')
          expect($.store.get('key')).toEqual 'value'
          $.store.remove('key')
          expect($.store.get('key')).toEqual undefined

    describe 'without localStorage and without JSON', ->
      beforeEach ->
        $.store.storage = {}
        $.store.local_storage_valid = false
        $.store.json_object = null

      describe '.storage', ->
        it 'should not be window.localStorage', ->
          expect($.store.storage).toEqual {}

      describe '.json_object', ->
        it 'should not be window.JSON', ->
          expect($.store.json_object).toEqual null

      describe 'can save and load', ->
        it 'string', ->
          $.store.set('key', 'value')
          expect($.store.get('key')).toEqual 'value'

        it 'number', ->
          $.store.set('key', 1)
          expect($.store.get('key')).toEqual 1
          $.store.set('key', 1.23)
          expect($.store.get('key')).toEqual 1.23
          $.store.set('key', -1.23)
          expect($.store.get('key')).toEqual -1.23

        it 'boolean', ->
          $.store.set('key', true)
          expect($.store.get('key')).toEqual true
          $.store.set('key', false)
          expect($.store.get('key')).toEqual false

        it 'array', ->
          $.store.set('key', [1,2,true,'string'])
          expect($.store.get('key')).toEqual [1,2,true,'string']

        it 'object(hash)', ->
          $.store.set('key', {a:1,b:2,c:true,d:'string'})
          expect($.store.get('key')).toEqual {a:1,b:2,c:true,d:'string'}

      describe 'can save but cannot load expected', ->
        it 'date', ->
          $.store.set('key', new Date(2012, 11, 31, 23, 9, 59))
          expect($.store.get('key')).toMatch /^2012-12-31T14:09:59(|.000)Z$/
          $.store.set('key', new Date(1999, 1, 2, 3, 4, 5, 67))
          expect($.store.get('key')).toMatch /^1999-02-01T18:04:05(|.067)Z$/
          $.store.set('key', new Date(1999, 1, 2, 3, 4, 5, 678))
          expect($.store.get('key')).toMatch /^1999-02-01T18:04:05(|.678)Z$/

        it 'regexp', ->
          $.store.set('key', /regexp/)
          expect($.store.get('key')).toEqual {}
          $.store.set('key', [/regexp/])
          expect($.store.get('key')).toEqual [{}]

        it 'function', ->
          $.store.set('key', () ->)
          expect($.store.get('key')).toEqual undefined
          $.store.set('key', [() ->])
          expect($.store.get('key')).toEqual [null]

        it 'null', ->
          $.store.set('key', null)
          expect($.store.get('key')).toEqual null
          $.store.set('key', [null])
          expect($.store.get('key')).toEqual [null]

        it 'undefined', ->
          $.store.set('key', undefined)
          expect($.store.get('key')).toEqual undefined
          $.store.set('key', [undefined])
          expect($.store.get('key')).toEqual [null]

      describe '.remove', ->
        it 'can remove saved object', ->
          $.store.set('key', 'value')
          expect($.store.get('key')).toEqual 'value'
          $.store.remove('key')
          expect($.store.get('key')).toEqual undefined

  else if navigator.userAgent.toLowerCase().indexOf('msie') != -1
    describe 'with userData', ->
      describe '.storage', ->
        it 'should be userData', ->
          expect($.store.local_storage_valid).toEqual false
          expect($.store.user_data_valid).toEqual true

      describe 'can save and load', ->
        it 'string', ->
          $.store.set('key', 'value')
          expect($.store.get('key')).toEqual 'value'

        it 'number', ->
          $.store.set('key', 1)
          expect($.store.get('key')).toEqual 1
          $.store.set('key', 1.23)
          expect($.store.get('key')).toEqual 1.23
          $.store.set('key', -1.23)
          expect($.store.get('key')).toEqual -1.23

        it 'boolean', ->
          $.store.set('key', true)
          expect($.store.get('key')).toEqual true
          $.store.set('key', false)
          expect($.store.get('key')).toEqual false

        it 'array', ->
          $.store.set('key', [1,2,true,'string'])
          expect($.store.get('key')).toEqual [1,2,true,'string']

        it 'object(hash)', ->
          $.store.set('key', {a:1,b:2,c:true,d:'string'})
          expect($.store.get('key')).toEqual {a:1,b:2,c:true,d:'string'}

      describe 'can save but cannot load expected', ->
        it 'date', ->
          $.store.set('key', new Date(2012, 11, 31, 23, 9, 59))
          expect($.store.get('key')).toMatch /^2012-12-31T14:09:59(|.000)Z$/
          $.store.set('key', new Date(1999, 1, 2, 3, 4, 5, 67))
          expect($.store.get('key')).toMatch /^1999-02-01T18:04:05(|.067)Z$/
          $.store.set('key', new Date(1999, 1, 2, 3, 4, 5, 678))
          expect($.store.get('key')).toMatch /^1999-02-01T18:04:05(|.678)Z$/

        it 'regexp', ->
          $.store.set('key', /regexp/)
          expect($.store.get('key')).toEqual {}
          $.store.set('key', [/regexp/])
          expect($.store.get('key')).toEqual [{}]

        it 'function', ->
          $.store.set('key', () ->)
          expect($.store.get('key')).toEqual undefined
          $.store.set('key', [() ->])
          expect($.store.get('key')).toEqual [null]

        it 'null', ->
          $.store.set('key', null)
          expect($.store.get('key')).toEqual null
          $.store.set('key', [null])
          expect($.store.get('key')).toEqual [null]

        it 'undefined', ->
          $.store.set('key', undefined)
          expect($.store.get('key')).toEqual undefined
          $.store.set('key', [undefined])
          expect($.store.get('key')).toEqual [null]

      describe '.remove', ->
        it 'can remove saved object', ->
          $.store.set('key', 'value')
          expect($.store.get('key')).toEqual 'value'
          $.store.remove('key')
          expect($.store.get('key')).toEqual undefined
