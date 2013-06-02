@echo off
echo Building Flash ...
haxelib run openfl build "MainH2D.xml" flash
haxelib run openfl build "MainH3D.xml" flash
echo Building HTML5 ...
haxelib run openfl build "MainH2D.xml" html5
haxelib run openfl build "MainH3D.xml" html5