# jQuery Store

jQuery Store is a light-weight plugin to save and load objects safely. The plugin convert almost all types of objects into JSON strings and save them in localStorage or userData. [[日本語](https://github.com/ysawa/jquery-store/blob/master/README.ja.markdown)]


## Features

### Light-weight

jquery.store.min.js is just 2.658 kb.

### Safe

If you use a browser imcompatible with localStorage, some operations around localStorage sometimes raise errors. However, this plugin prevents those errors and stopping other important programs. You can use localStorage safely without being frustrated.

### Compatible With Many Types

* string
* array
* object(hash)
* number
* boolean
* null

date, function, and undefined are not processed well. This plugin processes those objects as Some implementation of JSON.stringify do.

The datum of date is converted to the string of ISO 8601 Time format.

    YYYY-MM-DDThh:mm:ssZ (eg 1997-07-16T19:20:30Z)

    or

    YYYY-MM-DDThh:mm:ss.sZ (eg 1997-07-16T19:20:30.045Z)


## Usage

You can use this plugin if you only include jQuery(1.4.1 or above) and jquery.store.min.js .

    // load an object from storage
    var value = $.store.get('key');

    // save an object into storage
    $.store.set('key', 'value');

    // remove an object from storage
    $.store.remove('key');


## Environments

The plugin is tested with Jasmine(1.2.0) and those browsers below passed all specs:

* Safari 6.0 (7536.25) (Mac OS X 10.7.4)
* Google Chrome 22.0.1229.94 (Mac OS X 10.7.4)
* Firefox 8.0.1 (Mac OS X 10.7.4)
* Opera 12.02 (Mac OS X 10.7.4)
* IE 10.0.8250.0 (Windows 8 Customer Preview Build 8250)
* IE 8.0.6001.18702 (Windows XP Service Pack 3)
* Google Chrome 21.0.1180.89 (Windows XP Service Pack 3)
* Firefox 7.0.1 (Windows XP Service Pack 3)
* Opera 12.02 (Windows XP Service Pack 3)


## Further Information

If you use a browser incompatible with localStorage, jQuery Store tries to use userData as a storage. For example, IE6/7 are not compatible with localStorage and adopt userData. When the plugin knows neigher is available, it uses only a hash as a storage. Thus, if you reload your browser in that condition, all data saved will be removed.

Notice userData as a storage is slower and smaller than localStorage. Take care in case you operate large data many times.


## Copyright

Copyright (c) 2012 Yoshihiro Sawa. See LICENSE.txt for further details.
