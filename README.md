BWS - Basic Web Server
======================

About
-----

**BWS** is a **dart-based** web server that provides static files for
developers to test your websites locally  
without the weight of Apache.

How to use
----------

**FIRST** Install the **DartVM** via [DartSDK](https://www.dartlang.org/tools/sdk/#getting-the-sdk).   

**SECOND** After the install, go to the folder you have downloaded the **BWS**, via terminal, and then  
runs `pub get` once, to download all packages the server needs.

**THIRD** Create a folder in the root of **BWS** project called 'web/' and put your web files inside. _It can  
be a symlink from your site folder._ After this, run the command `pub build` in the **BWS** root folder.

**FOURTH** To run the server, uses the command `dart bin/bws.dart` in the root folder of **BWS**.

**FOURTH.1** To test the changes you have done in your website/webapp files, just save the files you  
are working. The **BWS** now recognizes changes and recompile the code to be served and tested in  
the web browser, when it is running.

**FIFTH** ENJOY!

Future
------

The Venosyd Open Source Team **{ THE VOST }** will extend the server to more complex and delicious  
funcionalities.

Changelog
---------
[2016-04-25] Adds the directory watcher functionality. When the developers finish their work, saves  
the files, the server recognizes, compile and serve for tests.

[2016-04-24] Project creation

Contact
-------

[The Venosyd Open Source Team](http://venosyd.com/opensource)  
`thevost@venosyd.com`

venosyd ©2016
