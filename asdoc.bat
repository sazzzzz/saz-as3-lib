@ECHO OFF

REM "C:\ols\flex_sdk_4.1\bin\asdoc.exe" -main-title "sazLib_as3" -output "E:\_saz\LIB\saz\as3\doc" -doc-sources "E:\_saz\LIB\saz\as3\work\src\saz" -source-path "E:\_saz\LIB\saz\as3\work\src" -library-path "C:\Program Files\Adobe\Adobe Flash CS5.5\Common\Configuration\ActionScript 3.0\FP10" -library-path "C:\Program Files\Adobe\Adobe Flash CS5.5\Common\Configuration\ActionScript 3.0\AIR2.5" -library-path "E:\_saz\LIB\saz\as3\work\swc" -compiler.strict=false  -compiler.show-actionscript-warnings=false
"C:\ols\flex_sdk_4.1\bin\asdoc.exe" -main-title "sazLib_as3" -output "E:\_saz\LIB\saz\as3\doc" -doc-sources "E:\_saz\LIB\saz\as3\work\src\saz" -source-path "E:\_saz\LIB\saz\as3\work\src" -library-path "C:\Program Files\Adobe\Adobe Flash CS5.5\Common\Configuration\ActionScript 3.0\FP9" -library-path "C:\Program Files\Adobe\Adobe Flash CS5.5\Common\Configuration\ActionScript 3.0\AIR2.5" -library-path "E:\_saz\LIB\saz\as3\work\swc" -compiler.strict=false
PAUSE

REM 説明
REM "C:\ols\flex_sdk_4.1\bin\asdoc.exe"
REM -main-title "sazLib_as3"			タイトル
REM -output "E:\_saz\LIB\saz\as3\doc"	出力先パス
REM -doc-sources "E:\_saz\LIB\saz\as3\work\src\saz"	ドキュメント生成するソースパス
REM -source-path "E:\_saz\LIB\saz\as3\work\src"		対象とするasファイルへのパス（）
REM -library-path "C:\Program Files\Adobe\Adobe Flash CS5.5\Common\Configuration\ActionScript 3.0\FP10" 	対象とするswcファイルへのパス（ドキュメントは生成しない）
REM -compiler.strict=false								エラーチェックをゆるく
REM -compiler.show-actionscript-warnings=false			？


REM ライブラリパス
REM C:\Program Files\Adobe\Adobe Flash CS5.5\Common\Configuration\ActionScript 3.0\FP10
REM C:\Program Files\Adobe\Adobe Flash CS5.5\Common\Configuration\ActionScript 3.0\AIR2.5


REM 参考文献
REM http://blog.yaimo.net/tag/asdoc/
REM http://www.nilab.info/zurazure2/000852.html
REM http://ja.w3support.net/index.php?db=so&id=853683





REM FD付属ツール＞"C:\ols\flex_sdk_4.1\bin\asdoc.exe" -main-title "sazLib as3" -output "E:\_saz\LIB\saz\as3\doc" -title "sazLib as3" -window-title "sazLib as3" -compiler.strict=false -compiler.show-actionscript-warnings=false -source-path ./src -doc-sources ./src/saz -compiler.external-library-path ./swc 
