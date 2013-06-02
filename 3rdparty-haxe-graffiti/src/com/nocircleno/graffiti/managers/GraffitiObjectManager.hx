////////////////////////////////////////////////////////////////////////////////
//=BEGIN LICENSE MIT
//
// Copyright (c) 2012-2013, Original author & contributors
// Original author : www.nocircleno.com/graffiti/
// Contributors: Andras Csizmadia <andras@vpmedia.eu>
// 
// Permission is hereby granted, free of charge, to any person obtaining
// a copy of this software and associated documentation files (the
// "Software"), to deal in the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to
// permit persons to whom the Software is furnished to do so, subject to
// the following conditions:
// 
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//  
//=END LICENSE MIT
////////////////////////////////////////////////////////////////////////////////
package com.nocircleno.graffiti.managers;
import com.nocircleno.graffiti.display.GraffitiObject;
import com.nocircleno.graffiti.display.Text;
import com.nocircleno.graffiti.tools.TextSettings;
import com.nocircleno.graffiti.events.GraffitiObjectEvent;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.geom.Point;
/**
* GraffitiObjectManager Class manages graffiti objects on the GraffitiCanvas.  This is a singleton class, use the GraffitiObjectManager.getInstance() method to get an instance of this class.
*
* @langversion 3.0
* @playerversion Flash 10 AIR 1.5 
*/
class GraffitiObjectManager extends EventDispatcher {
    static var _instance : GraffitiObjectManager;
    var _objects : Array<GraffitiObject>;
    var _selectedObjects : Array<GraffitiObject>;
    var _pendingSettings : Dynamic;
    /**
    * The <code>getInstance</code> method returns an instance of GraffitiObjectManager.
    * 
    * @return GraffitiObjectManager instance.
    */    
    static public function getInstance() : GraffitiObjectManager {
        return _instance != null ? _instance : _instance = new GraffitiObjectManager(new SingletonEnforcer());
    }
    /**
    * The <code>GraffitiObjectManager</code> constructor.
    * @example The following code gets an instance of the GraffitiObjectManager.
    * <listing version="3.0" >
    * var goManager:GraffitiObjectManager = GraffitiObjectManager.getInstance();
    * </listing>
    */    
    public function new(param : SingletonEnforcer) {
        super();
    init();
    }
    /**
    * The <code>areObjectsSelected</code> method checks to see if any object is currently selected.
    * 
    * @return true if one or more objects are selected, false if not.
    */    
    public function areObjectsSelected() : Bool {
        var isSelected : Bool = false;
        var numObjects : Int = _objects.length;
        var i : Int = 0;
        while(i < numObjects) {
            if(_objects[i].selected)  {
                isSelected = true;
                break;
            }
            ++i;
        }
        return isSelected;
    }
    /**
    * The <code>areObjectsBeingEdited</code> method checks to see if any object is being edited.
    * 
    * @return true if one or more objects are edited, false if not.
    */    
    public function areObjectsBeingEdited() : Bool {
        var isEdit : Bool = false;
        var numObjects : Int = _objects.length;
        var i : Int = 0;
        while(i < numObjects) {
            if(_objects[i].editing)  {
                isEdit = true;
                break;
            }
            ++i;
        }
        return isEdit;
    }
    /**
    * The <code>changeSettingsForSelectedObjects</code> method updates the settings for all selected objects.
    * 
    * @param settings Object that contains the settings for a GraffitObject.
    */    
    public function changeSettingsForSelectedObjects(settings : Dynamic) : Void {
        // store pending settings object
        _pendingSettings = settings;
        // update all settings
        //_selectedObjects.forEach(changeSettings, null);
    for(i in 0..._selectedObjects.length)
    {
       changeSettings(_selectedObjects[i],i,_selectedObjects);
    }
        // remove pending settings
        _pendingSettings = null;
    }
    /**
    * The <code>addObject</code> method adds a GraffitObject to the assets list held by this Class.
    * 
    * @param object GraffitObject
    */    
    public function addObject(object : GraffitiObject) : Void {
        // add listener so we know it it is removed from the stage
        object.addEventListener(Event.REMOVED_FROM_STAGE, cleanUp);
        // add to object list
        _objects.push(object);
    }
    /**
    * The <code>setSelection</code> method selects one or more grafffiti objects.
    * 
    * @param objectList Vector of GraffitObjects to select.
    */    
    public function setSelection(objectList : Array<GraffitiObject>) : Void {
        // make unique copy of the vector
        _selectedObjects = objectList.concat(new Array<GraffitiObject>());
        // select each object in the vector
        if(_selectedObjects.length > 0)  {
            for(i in 0..._selectedObjects.length)
      {
        selectObject(_selectedObjects[i],i,_selectedObjects);
      }
      //_selectedObjects.forEach(selectObject, null);
        }
        // sync selection list with the main list
        if(_objects.length > 0)  {
            for(i in 0..._selectedObjects.length)
      {
        syncListWithSelection(_objects[i],i,_objects);
      }
      //_objects.forEach(syncListWithSelection, null);
        }
    }
    /**
    * The <code>deselectAll</code> method deselects all selected objects.
    */    
    public function deselectAll() : Void {
        // deselect all object in vector
        if(_selectedObjects.length > 0)  {                 
      for(i in 0..._selectedObjects.length)
      {
        deselectObject(_selectedObjects[i],i,_selectedObjects);
      }  
      //_selectedObjects.forEach(deselectObject);
        }
        // clear selected object vector
        _selectedObjects = new Array<GraffitiObject>();
    }
    /**
    * The <code>selectAll</code> method selects all registered objects.
    */    
    public function selectAll() : Void {
        if(_objects.length > 0)  {
            setSelection(_objects);
        }
    }
    /**
    * The <code>exitEditAll</code> method will turn off any object that is being edited.
    */    
    public function exitEditAll() : Void {
        var numObjects : Int = _objects.length - 1;
        var i : Int = numObjects;
        while(i >= 0) {
            if(_objects[i].editing)  {
                _objects[i].editing = false;
            }
            i--;
        }
    }
    /**
    * The <code>deleteSelected</code> method deletes all selected objects.
    * This method removes the objects from the display list.
    */    
    public function deleteSelected() : Void {
        var numSelectedObjects : Int = _selectedObjects.length - 1;
        // loop and delete all objects in the selected list
        var i : Int = numSelectedObjects;
        while(i >= 0) {
            if(!_selectedObjects[i].editing)  {
                dispatchEvent(new GraffitiObjectEvent(_selectedObjects[i], GraffitiObjectEvent.DELETE));
            }
            --i;
        }
    }
    /**************************************************************************
    Method    : init()
    
    Purpose    : This method will initalize the data to hold the objects.
    ***************************************************************************/    
    function init() : Void {
        if(_objects != null)  {
            return;
        }
        _objects = new Array<GraffitiObject>();
        _selectedObjects = new Array<GraffitiObject>();
    }
    /**************************************************************************
    Method    : changeSettings()
    
    Purpose    : This method changes the settings for an object.
    
    Params    : item - GraffitiObject
      index - index of graffiti object in vector.
      vector - The vector that stores the graffiti objects.
    ***************************************************************************/    
    function changeSettings(item : GraffitiObject, index : Int, vector : Array<GraffitiObject>) : Void {
        // update text settings if item is text and pending settings is textsettings
        if(Std.is(item, Text) && Std.is(_pendingSettings, TextSettings))  {
            cast((item), Text).textSetting = cast((_pendingSettings), TextSettings);
        }
;
    }
    /**************************************************************************
    Method    : removeObject()
    
    Purpose    : This method will remove a graffiti object from the manager.
      This method does not remove the object from the display
      list.
    
    Params    : object - GraffitiObject
    ***************************************************************************/    
    public function removeObject(object : GraffitiObject) : Void {
        // check and remove object from object list
        var itemIndex : Int = Lambda.indexOf(_objects,object);
        if(itemIndex != -1)  {
            _objects.splice(itemIndex, 1);
        }
        // check and remove object from selected list
        itemIndex = Lambda.indexOf(_selectedObjects,object);
        if(itemIndex != -1)  {
            _selectedObjects.splice(itemIndex, 1);
        }
    }
    /**************************************************************************
    Method    : syncListWithSelection()
    
    Purpose    : This method will make sure if an item is in the main object
      list and not in the selected list, it will deselect
      that object.
    
    Params    : item - GraffitiObject
      index - index of graffiti object in vector.
      vector - The vector that stores the graffiti objects.
    ***************************************************************************/    
    function syncListWithSelection(item : GraffitiObject, index : Int, vector : Array<GraffitiObject>) : Void {
        // if item is not in selected object list
        if(Lambda.indexOf(_selectedObjects,item) == -1)  {
            // if object is selected, then deselect it
            if(item.selected)  {
                item.selected = false;
                item.editing = false;
                dispatchEvent(new GraffitiObjectEvent(item, GraffitiObjectEvent.DESELECT));
            }
        }
    }
    /**************************************************************************
    Method    : cleanUp()
    
    Purpose    : This method will handle the remove child from stage event
      for a graffiti object.
    
    Params    : e - Event Object
    ***************************************************************************/    
    function cleanUp(e : Event) : Void {
        e.currentTarget.removeEventListener(Event.REMOVED_FROM_STAGE, cleanUp);
        removeObject(cast((e.currentTarget), GraffitiObject));
    }
    /**************************************************************************
    Method    : selectObject()
    
    Purpose    : This method will select a graffiti object if not already
      selected.
    
    Params    : item - GraffitiObject
      index - index of graffiti object in vector.
      vector - The vector that stores the graffiti objects.
    ***************************************************************************/    
    function selectObject(item : GraffitiObject, index : Int, vector : Array<GraffitiObject>) : Void {
        if(!item.selected)  {
            item.selected = true;
            dispatchEvent(new GraffitiObjectEvent(item, GraffitiObjectEvent.SELECT));
        }
    }
    /**************************************************************************
    Method    : deselectObject()
    
    Purpose    : This method will deselect a graffiti object if already
      selected.
    
    Params    : item - GraffitiObject
      index - index of graffiti object in vector.
      vector - The vector that stores the graffiti objects.
    ***************************************************************************/    
    function deselectObject(item : GraffitiObject, index : Int, vector : Array<GraffitiObject>) : Void {
        if(item.selected)  {
            item.selected = false;
            // turn off editing
            if(item.editing)  {
                item.editing = false;
            }
            dispatchEvent(new GraffitiObjectEvent(item, GraffitiObjectEvent.DESELECT));
        }
    }
}
class SingletonEnforcer {
    public function new() {
    }
}