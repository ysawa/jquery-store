# jQuery Store

jQuery Store can save and load almost all type of objects. The plugin convert objects into JSON strings and save them in localStorage.


## Compatibility

### Types

* string
* array
* object(hash)
* number
* boolean
* null

date, function, and undefined are not compatible well.

The data of date is converted to the one of ISO 8601 Time format.

    YYYY-MM-DDThh:mm:ss.sZ (eg 1997-07-16T19:20:30.45Z)


## Usage

    $.store.get('key')

    $.store.set('key', 'value')

    $.store.remove('key')

    $.store.remove_all()
