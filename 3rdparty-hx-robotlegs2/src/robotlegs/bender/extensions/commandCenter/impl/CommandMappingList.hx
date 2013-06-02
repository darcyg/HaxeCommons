package robotlegs.bender.extensions.commandcenter.impl;

import robotlegs.bender.extensions.commandcenter.api.ICommandMapping;

class CommandMappingList {
    public var head(getHead, setHead) : ICommandMapping;
    public var tail(getTail, never) : ICommandMapping;

    var _head : ICommandMapping;
    public function getHead() : ICommandMapping {
        return _head;
    }

    public function setHead(value : ICommandMapping) : ICommandMapping {
        if(value != _head)  {
            _head = value;
        }
        return value;
    }

    public function getTail() : ICommandMapping {
        if(_head == null) 
            return null;
        var theTail : ICommandMapping = _head;
        while(theTail.next != null) {
            theTail = theTail.next;
        }

        return theTail;
    }

    public function remove(item : ICommandMapping) : Void {
        var link : ICommandMapping = _head;
        if(link == item)  {
            _head = item.next;
        }
        while(link != null) {
            if(link.next == item)  {
                link.next = item.next;
            }
            link = link.next;
        }

    }


    public function new() {
    }
}

