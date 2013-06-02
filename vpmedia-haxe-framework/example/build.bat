@echo off
echo Building Flash ...
haxelib run openfl build "MVCExample.xml" flash
haxelib run openfl build "CommandsExample.xml" flash
echo Building HTML5 ...
haxelib run openfl build "MVCExample.xml" html5
haxelib run openfl build "CommandsExample.xml" html5