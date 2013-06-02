package robotlegs.bender.extensions.viewprocessormap.impl;

import robotlegs.bender.extensions.viewprocessormap.dsl.IViewProcessorUnmapper;

class NullViewProcessorUnmapper implements IViewProcessorUnmapper {

    //---------------------------------------
        // IViewProcessorUnmapper Implementation
        //---------------------------------------
        public function fromProcess(processorClassOrInstance : Dynamic) : Void {
    }

    public function fromProcesses() : Void {
    }

    public function fromNoProcess() : Void {
    }

    public function fromInjection() : Void {
    }


    public function new() {
    }
}

