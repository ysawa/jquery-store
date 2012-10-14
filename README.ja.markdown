# jQuery Store

jQuery Store は安全にオブジェクトを保存したり読み込むための軽量プラグインです。オブジェクトはJSONの文字列に変換され localStorage に保存されます。


## Features

### Safe

localStorage に対応していないブラウザの場合、 localStorage の操作はエラーを発生させることがあります。しかし、このプラグインを使うことで、これらのエラーの発生や他の大事なプログラムを止めてしまうことが防げます。localStorage を安全にイライラすることなく使うことができます。

### Compatible With Many Types

* string
* array
* object(hash)
* number
* boolean
* null

date, regexp, function, and undefined are not compatible well.

The data of date is converted to the one of ISO 8601 Time format.

    YYYY-MM-DDThh:mm:ss.sZ (eg 1997-07-16T19:20:30.045Z)


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


## Environments

Jasmine(1.2.0) を使ってテストをしています。以下の環境で全てのテストが通ることを確認しました。

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

localStorage に対応していないブラウザの場合、jQuery Store は連想配列(hash)をストレージとして使用します。ゆえに、ブラウザをリロードすると全てのデータは失われます。(このプラグインは他のストレージ系プラグインの様に userData を使用して IE6/7 に対応することはしていません。)


## Copyright

Copyright (c) 2012 Yoshihiro Sawa. 詳細は LICENSE.txt をお読みください。
