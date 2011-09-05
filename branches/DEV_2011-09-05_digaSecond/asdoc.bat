@ECHO OFF

REM FP9
"C:\ols\flex_sdk_3.5\bin\asdoc.exe" -main-title "sazLib_as3" -title "sazLib_as3" -window-title "sazLib_as3" -output "E:\_saz\LIB\saz\as3\doc" -doc-sources "E:\_saz\LIB\saz\as3\work\src\saz" -source-path "E:\_saz\LIB\saz\as3\work\src" -library-path "C:\Program Files\Adobe\Adobe Flash CS5.5\Common\Configuration\ActionScript 3.0\FP10" -library-path "E:\_saz\LIB\saz\as3\work\swc" -compiler.strict=false -compiler.show-actionscript-warnings=false

REM Flex4のasdocはエラーチェックが厳しいらしい…
REM 　〃　はコメント中のHTMLタグにエラーを出す。http://kcw-diary.blogspot.com/2011/01/asdoc.html


REM AIR2.5
REM "C:\ols\flex_sdk_4.1\bin\asdoc.exe" -main-title "sazLib_as3" -title "sazLib_as3" -window-title "sazLib_as3" -output "E:\_saz\LIB\saz\as3\doc" -doc-sources "E:\_saz\LIB\saz\as3\work\src\saz" -source-path "E:\_saz\LIB\saz\as3\work\src" -library-path "C:\Program Files\Adobe\Adobe Flash CS5.5\Common\Configuration\ActionScript 3.0\AIR2.5" -library-path "E:\_saz\LIB\saz\as3\work\swc" -compiler.strict=false -compiler.show-actionscript-warnings=false

REM 
REM "C:\ols\flex_sdk_4.1\bin\asdoc.exe" -main-title "sazLib_as3" -title "sazLib_as3" -window-title "sazLib_as3" -output "E:\_saz\LIB\saz\as3\doc" -doc-sources "E:\_saz\LIB\saz\as3\work\src\saz" -source-path "E:\_saz\LIB\saz\as3\work\src" -library-path "C:\Program Files\Adobe\Adobe Flash CS5.5\Common\Configuration\ActionScript 3.0\FP10" -library-path "C:\Program Files\Adobe\Adobe Flash CS5.5\Common\Configuration\ActionScript 3.0\AIR2.5" -library-path "E:\_saz\LIB\saz\as3\work\swc" -compiler.strict=false -compiler.show-actionscript-warnings=false
PAUSE


REM シグネチャがどうのエラー
REM saz.display.dialog.DialogBackgroundBase saz.display.dialog.DialogBase saz.outside.progression4.RectCastButton

REM AIR
REM E:\_saz\LIB\saz\as3\work\src\saz\util\FilesystemUtil.as
REM E:\_saz\LIB\saz\as3\work\src\saz\outside\progression4\AsyncWriteFile.as



REM 説明
REM "C:\ols\flex_sdk_4.1\bin\asdoc.exe"
REM -main-title "sazLib_as3"			タイトル
REM -output "E:\_saz\LIB\saz\as3\doc"	出力先パス
REM -doc-sources "E:\_saz\LIB\saz\as3\work\src\saz"	ドキュメント生成するソースパス
REM -source-path "E:\_saz\LIB\saz\as3\work\src"		対象とするasファイルへのパス（）
REM -library-path "C:\Program Files\Adobe\Adobe Flash CS5.5\Common\Configuration\ActionScript 3.0\FP10" 	対象とするswcファイルへのパス（ドキュメントは生成しない）
REM -compiler.strict=false								エラーチェックをゆるく
REM -compiler.show-actionscript-warnings=false			？
REM -lenient		HTMLタグの閉じタグにミスがあっても、ASDocを作成してくれます
REM					http://flabaka.com/blog/?p=2444

REM -templates-path string	ASDocテンプレートへのパス


REM ライブラリパス
REM C:\Program Files\Adobe\Adobe Flash CS5.5\Common\Configuration\ActionScript 3.0\FP10
REM C:\Program Files\Adobe\Adobe Flash CS5.5\Common\Configuration\ActionScript 3.0\AIR2.5


REM 参考文献
REM http://livedocs.adobe.com/flex/3_jp/html/help.html?content=asdoc_9.html
REM http://blog.yaimo.net/tag/asdoc/
REM http://www.nilab.info/zurazure2/000852.html
REM http://ja.w3support.net/index.php?db=so&id=853683





REM FD付属ツール＞"C:\ols\flex_sdk_4.1\bin\asdoc.exe" -main-title "sazLib as3" -output "E:\_saz\LIB\saz\as3\doc" -title "sazLib as3" -window-title "sazLib as3" -compiler.strict=false -compiler.show-actionscript-warnings=false -source-path ./src -doc-sources ./src/saz -compiler.external-library-path ./swc 
