//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.bundles.shared.configs;

import flash.display.DisplayObjectContainer;
import robotlegs.bender.extensions.viewmanager.api.IViewManager;
import robotlegs.bender.framework.api.IConfig;

/**

 * This simple configuration adds the mapped DisplayObjectContainer ("contextView")

 * to the viewManager.

 */class ContextViewListenerConfig implements IConfig{

    /*============================================================================*/
    /* Public Properties                                                          */
    /*============================================================================*/
    @inject
    public var contextView : DisplayObjectContainer;
    
    @inject
    public var viewManager : IViewManager;
    /*============================================================================*/
    /* Public Functions                                                           */
    /*============================================================================*/
    public function configure() : Void {
        viewManager.addContainer(contextView);
    }


    public function new() {
    }
}

