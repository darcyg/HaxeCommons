@echo off
echo Building Flash ...
haxelib run openfl build "Main.xml" flash
echo Building HTML5 ...
haxelib run openfl build "Main.xml" html5