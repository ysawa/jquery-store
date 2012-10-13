# jQuery Store

jQuery Store is a light-weight plugin to save and load objects safely. The plugin convert almost all types of objects into JSON strings and save them in localStorage.


## Usage

    // load an object from storage
    $.store.get('key')

    // save an object into storage
    $.store.set('key', 'value')

    // remove an object from storage
    $.store.remove('key')

    // remove all object from storage
    $.store.remove_all()


## Compatibility

### Storage

If you have a browser incompatible with localStorage, jQuery Store use only a hash as a storage. Thus, if you reload your browser, all data saved will be removed. (The plugin is not compatible with userData for IE6/7 as other storage plugins.)

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


## Copyright

Copyright (c) 2012 Yoshihiro Sawa. See LICENSE.txt for further details.
