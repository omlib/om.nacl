package om.nacl;

import js.Browser.document;
import js.html.EmbedElement;
import js.html.MessageEvent;

/**
	A native client module.

    https://developer.chrome.com/native-client
*/
class Module {

    public static inline var MIME_TYPE = 'application/x-pnacl';

    public dynamic function onLoad() {}
	public dynamic function onError( msg : String ) {}
	public dynamic function onMessage( msg : String ) {}

    public var element(default,null) : EmbedElement;

    public function new( element : EmbedElement ) {

        this.element = element;

        element.addEventListener( 'load', handleModuleLoad, false );
		element.addEventListener( 'message', handleModuleMessage, false );
		element.addEventListener( 'abort', handleModuleAbort, false );
		element.addEventListener( 'error', handleModuleError, false );
    }

    public function post( msg : String ) {
        untyped element.postMessage( msg );
    }

    public function dispose() {
        element.removeEventListener( 'load', handleModuleLoad );
        element.removeEventListener( 'message', handleModuleMessage );
        element.removeEventListener( 'abort', handleModuleAbort );
		element.removeEventListener( 'error', handleModuleError );
    }

    function handleModuleLoad(e) {
        onLoad();
    }

    function handleModuleMessage( e : MessageEvent ) {
        onMessage( e.data );
    }

    function handleModuleAbort(e) {
        //TODO
        trace(e);
    }

    function handleModuleError(e) {
        //TODO
        trace(e);
        onError( e.data );
    }

    public static function create( name : String, ?nmf : String ) : Module {
        var e = document.createEmbedElement();
        e.name = name;
        e.src = (nmf == null) ? '$name.nmf' : nmf;
        e.type = MIME_TYPE;
        return new Module( e );
    }
}
