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

    // load an object from storage
    $.store.get('key')

    // save an object into storage
    $.store.set('key', 'value')

    // remove an object from storage
    $.store.remove('key')

    // remove all object from storage
    $.store.remove_all()

## Copyright

Copyright (c) 2012 Yoshihiro Sawa. See LICENSE.txt for further details.
