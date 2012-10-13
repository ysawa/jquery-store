describe '$.store', ->
  beforeEach ->
    if window.localStore
      window.localStore.clear()

  describe 'with localStorage and JSON', ->
    describe '.storage', ->
      it 'should be window.localStorage', ->
        expect($.store.storage).toEqual window.localStorage

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

  describe 'with localStorage and without JSON', ->
    beforeEach ->
      $.store.json_object = null

    describe '.storage', ->
      it 'should be window.localStorage', ->
        expect($.store.storage).toEqual window.localStorage

    describe '.json_object', ->
      it 'should be null', ->
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

  # describe 'without localStorage and with JSON', ->
  # describe 'without localStorage and without JSON', ->
