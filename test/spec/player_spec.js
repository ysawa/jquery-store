(function() {

  describe('$.store', function() {
    beforeEach(function() {
      if (window.localStore) {
        return window.localStore.clear();
      }
    });
    describe('with localStorage and JSON', function() {
      describe('.storage', function() {
        return it('should be window.localStorage', function() {
          return expect($.store.storage).toEqual(window.localStorage);
        });
      });
      describe('.json_object', function() {
        return it('should be window.JSON', function() {
          return expect($.store.json_object).toEqual(window.JSON);
        });
      });
      return describe('can save and load', function() {
        it('string', function() {
          $.store.set('key', 'value');
          return expect($.store.get('key')).toEqual('value');
        });
        it('number', function() {
          $.store.set('key', 1);
          expect($.store.get('key')).toEqual(1);
          $.store.set('key', 1.23);
          expect($.store.get('key')).toEqual(1.23);
          $.store.set('key', -1.23);
          return expect($.store.get('key')).toEqual(-1.23);
        });
        it('boolean', function() {
          $.store.set('key', true);
          expect($.store.get('key')).toEqual(true);
          $.store.set('key', false);
          return expect($.store.get('key')).toEqual(false);
        });
        it('array', function() {
          $.store.set('key', [1, 2, true, 'string']);
          return expect($.store.get('key')).toEqual([1, 2, true, 'string']);
        });
        return it('object(hash)', function() {
          $.store.set('key', {
            a: 1,
            b: 2,
            c: true,
            d: 'string'
          });
          return expect($.store.get('key')).toEqual({
            a: 1,
            b: 2,
            c: true,
            d: 'string'
          });
        });
      });
    });
    return describe('with localStorage and without JSON', function() {
      beforeEach(function() {
        return $.store.json_object = null;
      });
      describe('.storage', function() {
        return it('should be window.localStorage', function() {
          return expect($.store.storage).toEqual(window.localStorage);
        });
      });
      describe('.json_object', function() {
        return it('should be null', function() {
          return expect($.store.json_object).toEqual(null);
        });
      });
      return describe('can save and load', function() {
        it('string', function() {
          $.store.set('key', 'value');
          return expect($.store.get('key')).toEqual('value');
        });
        it('number', function() {
          $.store.set('key', 1);
          expect($.store.get('key')).toEqual(1);
          $.store.set('key', 1.23);
          expect($.store.get('key')).toEqual(1.23);
          $.store.set('key', -1.23);
          return expect($.store.get('key')).toEqual(-1.23);
        });
        it('boolean', function() {
          $.store.set('key', true);
          expect($.store.get('key')).toEqual(true);
          $.store.set('key', false);
          return expect($.store.get('key')).toEqual(false);
        });
        it('array', function() {
          $.store.set('key', [1, 2, true, 'string']);
          return expect($.store.get('key')).toEqual([1, 2, true, 'string']);
        });
        return it('object(hash)', function() {
          $.store.set('key', {
            a: 1,
            b: 2,
            c: true,
            d: 'string'
          });
          return expect($.store.get('key')).toEqual({
            a: 1,
            b: 2,
            c: true,
            d: 'string'
          });
        });
      });
    });
  });

}).call(this);
