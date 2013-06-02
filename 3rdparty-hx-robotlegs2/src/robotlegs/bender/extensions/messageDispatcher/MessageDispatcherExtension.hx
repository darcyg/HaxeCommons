//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.messagedispatcher;

import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.framework.api.IExtension;
import robotlegs.bender.framework.api.IMessageDispatcher;
import robotlegs.bender.framework.impl.MessageDispatcher;
import robotlegs.bender.framework.impl.UID;

class MessageDispatcherExtension implements IExtension {

    /*============================================================================*/    /* Private Properties                                                         */    /*============================================================================*/    var _uid : String;
    var _messageDispatcher : IMessageDispatcher;
    /*============================================================================*/    /* Constructor                                                                */    /*============================================================================*/    public function new(messageDispatcher : IMessageDispatcher = null) {
        _uid = UID.create(MessageDispatcherExtension);
        _messageDispatcher = messageDispatcher || new MessageDispatcher();
    }

    /*============================================================================*/    /* Public Functions                                                           */    /*============================================================================*/    public function extend(context : IContext) : Void {
        context.injector.mapValue(IMessageDispatcher,_messageDispatcher);
    }

    public function toString() : String {
        return _uid;
    }

}

