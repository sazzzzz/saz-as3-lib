@ECHO OFF

REM FP9
"C:\ols\flex_sdk_3.5\bin\asdoc.exe" -main-title "sazLib_as3" -title "sazLib_as3" -window-title "sazLib_as3" -output "E:\_saz\LIB\saz\as3\doc" -doc-sources "E:\_saz\LIB\saz\as3\work\src\saz" -source-path "E:\_saz\LIB\saz\as3\work\src" -library-path "C:\Program Files\Adobe\Adobe Flash CS5.5\Common\Configuration\ActionScript 3.0\FP10" -library-path "E:\_saz\LIB\saz\as3\work\swc" -compiler.strict=false -compiler.show-actionscript-warnings=false

REM Flex4��asdoc�̓G���[�`�F�b�N���������炵���c
REM �@�V�@�̓R�����g����HTML�^�O�ɃG���[���o���Bhttp://kcw-diary.blogspot.com/2011/01/asdoc.html


REM AIR2.5
REM "C:\ols\flex_sdk_4.1\bin\asdoc.exe" -main-title "sazLib_as3" -title "sazLib_as3" -window-title "sazLib_as3" -output "E:\_saz\LIB\saz\as3\doc" -doc-sources "E:\_saz\LIB\saz\as3\work\src\saz" -source-path "E:\_saz\LIB\saz\as3\work\src" -library-path "C:\Program Files\Adobe\Adobe Flash CS5.5\Common\Configuration\ActionScript 3.0\AIR2.5" -library-path "E:\_saz\LIB\saz\as3\work\swc" -compiler.strict=false -compiler.show-actionscript-warnings=false

REM 
REM "C:\ols\flex_sdk_4.1\bin\asdoc.exe" -main-title "sazLib_as3" -title "sazLib_as3" -window-title "sazLib_as3" -output "E:\_saz\LIB\saz\as3\doc" -doc-sources "E:\_saz\LIB\saz\as3\work\src\saz" -source-path "E:\_saz\LIB\saz\as3\work\src" -library-path "C:\Program Files\Adobe\Adobe Flash CS5.5\Common\Configuration\ActionScript 3.0\FP10" -library-path "C:\Program Files\Adobe\Adobe Flash CS5.5\Common\Configuration\ActionScript 3.0\AIR2.5" -library-path "E:\_saz\LIB\saz\as3\work\swc" -compiler.strict=false -compiler.show-actionscript-warnings=false
PAUSE


REM �V�O�l�`�����ǂ��̃G���[
REM saz.display.dialog.DialogBackgroundBase saz.display.dialog.DialogBase saz.outside.progression4.RectCastButton

REM AIR
REM E:\_saz\LIB\saz\as3\work\src\saz\util\FilesystemUtil.as
REM E:\_saz\LIB\saz\as3\work\src\saz\outside\progression4\AsyncWriteFile.as



REM ����
REM "C:\ols\flex_sdk_4.1\bin\asdoc.exe"
REM -main-title "sazLib_as3"			�^�C�g��
REM -output "E:\_saz\LIB\saz\as3\doc"	�o�͐�p�X
REM -doc-sources "E:\_saz\LIB\saz\as3\work\src\saz"	�h�L�������g��������\�[�X�p�X
REM -source-path "E:\_saz\LIB\saz\as3\work\src"		�ΏۂƂ���as�t�@�C���ւ̃p�X�i�j
REM -library-path "C:\Program Files\Adobe\Adobe Flash CS5.5\Common\Configuration\ActionScript 3.0\FP10" 	�ΏۂƂ���swc�t�@�C���ւ̃p�X�i�h�L�������g�͐������Ȃ��j
REM -compiler.strict=false								�G���[�`�F�b�N����邭
REM -compiler.show-actionscript-warnings=false			�H
REM -lenient		HTML�^�O�̕��^�O�Ƀ~�X�������Ă��AASDoc���쐬���Ă���܂�
REM					http://flabaka.com/blog/?p=2444

REM -templates-path string	ASDoc�e���v���[�g�ւ̃p�X


REM ���C�u�����p�X
REM C:\Program Files\Adobe\Adobe Flash CS5.5\Common\Configuration\ActionScript 3.0\FP10
REM C:\Program Files\Adobe\Adobe Flash CS5.5\Common\Configuration\ActionScript 3.0\AIR2.5


REM �Q�l����
REM http://livedocs.adobe.com/flex/3_jp/html/help.html?content=asdoc_9.html
REM http://blog.yaimo.net/tag/asdoc/
REM http://www.nilab.info/zurazure2/000852.html
REM http://ja.w3support.net/index.php?db=so&id=853683





REM FD�t���c�[����"C:\ols\flex_sdk_4.1\bin\asdoc.exe" -main-title "sazLib as3" -output "E:\_saz\LIB\saz\as3\doc" -title "sazLib as3" -window-title "sazLib as3" -compiler.strict=false -compiler.show-actionscript-warnings=false -source-path ./src -doc-sources ./src/saz -compiler.external-library-path ./swc 
