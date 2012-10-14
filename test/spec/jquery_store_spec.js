(function() {

  describe('$.store', function() {
    beforeEach(function() {
      if (window.localStore) {
        window.localStore.clear();
      }
      return $.store.initialize();
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
      describe('can save and load', function() {
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
      return describe('can save but cannot load expected', function() {
        it('function', function() {
          $.store.set('key', function() {});
          expect($.store.get('key')).toEqual(void 0);
          $.store.set('key', [function() {}]);
          return expect($.store.get('key')).toEqual([null]);
        });
        it('null', function() {
          $.store.set('key', null);
          expect($.store.get('key')).toEqual(null);
          $.store.set('key', [null]);
          return expect($.store.get('key')).toEqual([null]);
        });
        return it('undefined', function() {
          $.store.set('key', void 0);
          expect($.store.get('key')).toEqual(void 0);
          $.store.set('key', [void 0]);
          return expect($.store.get('key')).toEqual([null]);
        });
      });
    });
    describe('with localStorage and without JSON', function() {
      beforeEach(function() {
        return $.store.json_object = null;
      });
      describe('.storage', function() {
        return it('should be window.localStorage', function() {
          return expect($.store.storage).toEqual(window.localStorage);
        });
      });
      describe('.json_object', function() {
        return it('should not be window.JSON', function() {
          return expect($.store.json_object).toEqual(null);
        });
      });
      describe('can save and load', function() {
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
      return describe('can save but cannot load expected', function() {
        it('function', function() {
          $.store.set('key', function() {});
          expect($.store.get('key')).toEqual(void 0);
          $.store.set('key', [function() {}]);
          return expect($.store.get('key')).toEqual([null]);
        });
        it('null', function() {
          $.store.set('key', null);
          expect($.store.get('key')).toEqual(null);
          $.store.set('key', [null]);
          return expect($.store.get('key')).toEqual([null]);
        });
        return it('undefined', function() {
          $.store.set('key', void 0);
          expect($.store.get('key')).toEqual(void 0);
          $.store.set('key', [void 0]);
          return expect($.store.get('key')).toEqual([null]);
        });
      });
    });
    describe('without localStorage and with JSON', function() {
      beforeEach(function() {
        $.store.storage = {};
        return $.store.storage_valid = false;
      });
      describe('.storage', function() {
        return it('should not be window.localStorage', function() {
          return expect($.store.storage).toEqual({});
        });
      });
      describe('.json_object', function() {
        return it('should be window.JSON', function() {
          return expect($.store.json_object).toEqual(window.JSON);
        });
      });
      describe('can save and load', function() {
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
      return describe('can save but cannot load expected', function() {
        it('function', function() {
          $.store.set('key', function() {});
          expect($.store.get('key')).toEqual(void 0);
          $.store.set('key', [function() {}]);
          return expect($.store.get('key')).toEqual([null]);
        });
        it('null', function() {
          $.store.set('key', null);
          expect($.store.get('key')).toEqual(null);
          $.store.set('key', [null]);
          return expect($.store.get('key')).toEqual([null]);
        });
        return it('undefined', function() {
          $.store.set('key', void 0);
          expect($.store.get('key')).toEqual(void 0);
          $.store.set('key', [void 0]);
          return expect($.store.get('key')).toEqual([null]);
        });
      });
    });
    return describe('without localStorage and without JSON', function() {
      beforeEach(function() {
        $.store.storage = {};
        $.store.storage_valid = false;
        return $.store.json_object = null;
      });
      describe('.storage', function() {
        return it('should not be window.localStorage', function() {
          return expect($.store.storage).toEqual({});
        });
      });
      describe('.json_object', function() {
        return it('should not be window.JSON', function() {
          return expect($.store.json_object).toEqual(null);
        });
      });
      describe('can save and load', function() {
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
      return describe('can save but cannot load expected', function() {
        it('function', function() {
          $.store.set('key', function() {});
          expect($.store.get('key')).toEqual(void 0);
          $.store.set('key', [function() {}]);
          return expect($.store.get('key')).toEqual([null]);
        });
        it('null', function() {
          $.store.set('key', null);
          expect($.store.get('key')).toEqual(null);
          $.store.set('key', [null]);
          return expect($.store.get('key')).toEqual([null]);
        });
        return it('undefined', function() {
          $.store.set('key', void 0);
          expect($.store.get('key')).toEqual(void 0);
          $.store.set('key', [void 0]);
          return expect($.store.get('key')).toEqual([null]);
        });
      });
    });
  });

}).call(this);
