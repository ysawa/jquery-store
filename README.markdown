# jQuery Store

jQuery Store is a light-weight plugin to save and load objects safely. The plugin convert almost all types of objects into JSON strings and save them in localStorage.


## Features

### Safe

If you use a browser imcompatible with localStorage, some operations around localStorage must raise errors. However, this plugin prevents those errors. You can use localStorage safely without being frastrated.

### Compatible With Many Types

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

You can use this plugin if you only include jQuery(1.4.1 or above) and jquery.store.min.js .

    // load an object from storage
    var value = $.store.get('key');

    // save an object into storage
    $.store.set('key', 'value');

    // remove an object from storage
    $.store.remove('key');

    // remove all object from storage
    $.store.remove_all();


## Further Information

If you use a browser incompatible with localStorage, jQuery Store use only a hash as a storage. Thus, if you reload your browser, all data saved will be removed. (The plugin is not compatible with userData for IE6/7 as other storage plugins.)


## Copyright

Copyright (c) 2012 Yoshihiro Sawa. See LICENSE.txt for further details.
