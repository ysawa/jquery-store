# jQuery Store

jQuery Store は安全にオブジェクトを保存したり読み込むための軽量プラグインです。オブジェクトはJSONの文字列に変換され localStorage に保存されます。


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

    YYYY-MM-DDThh:mm:ss.sZ (eg 1997-07-16T19:20:30.45Z)


## Usage

jQuery(1.4.1以上) と jquery.store.min.js を読み込めばすぐに使えます。

    // ストレージからオブジェクトを読み込む
    var value = $.store.get('key');

    // ストレージにオブジェクトを保存する
    $.store.set('key', 'value');

    // ストレージからオブジェクトを消去する
    $.store.remove('key');

    // ストレージから全てのオブジェクトを消去する
    $.store.remove_all();


## Further Information

If you use a browser incompatible with localStorage, jQuery Store use only a hash as a storage. Thus, if you reload your browser, all data saved will be removed. (The plugin is not compatible with userData for IE6/7 as other storage plugins.)


## Copyright

Copyright (c) 2012 Yoshihiro Sawa. 詳細は LICENSE.txt をお読みください。
