# jQuery Store

jQuery Store is a light-weight plugin to save and load objects safely. The plugin convert almost all types of objects into JSON strings and save them in localStorage. [[日本語](https://github.com/ysawa/jquery-store/blob/master/README.ja.markdown)]


## Features

### Safe

If you use a browser imcompatible with localStorage, some operations around localStorage must raise errors. However, this plugin prevents those errors and stopping other important programs. You can use localStorage safely without being frustrated.

### Compatible With Many Types

* string
* array
* object(hash)
* number
* boolean
* null

date, function, and undefined are not compatible well.

The data of date is converted to the one of ISO 8601 Time format.

    YYYY-MM-DDThh:mm:ss.sZ (eg 1997-07-16T19:20:30.045Z)


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


## Environments

The plugin is tested with Jasmine(1.2.0) and those browsers below passed all specs:

* Safari 6.0 (7536.25) (Mac OS X 10.7.4)
* Google Chrome 22.0.1229.94 (Mac OS X 10.7.4)
* Firefox 8.0.1 (Mac OS X 10.7.4)
* Google Chrome 21.0.1180.89 (Windows XP Service Pack 3)
* Firefox 7.0.1 (Windows XP Service Pack 3)


## Further Information

If you use a browser incompatible with localStorage, jQuery Store use only a hash as a storage. Thus, if you reload your browser, all data saved will be removed. (The plugin is not compatible with userData for IE6/7 as other storage plugins.)


## Copyright

Copyright (c) 2012 Yoshihiro Sawa. See LICENSE.txt for further details.
