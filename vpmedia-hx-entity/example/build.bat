@echo off
echo Building Flash ...
haxelib run openfl build "EntityAsteroidsExample.xml" flash
haxelib run openfl build "EntitySpriteExample.xml" flash
echo Building HTML5 ...
haxelib run openfl build "EntityAsteroidsExample.xml" html5
haxelib run openfl build "EntitySpriteExample.xml" html5