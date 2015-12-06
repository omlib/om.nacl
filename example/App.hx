
import js.Browser.document;
import js.Browser.window;

class App {

    static var module : om.nacl.Module;

    static function handleModuleLoad() {
        module.post( 'hello' );
    }

    static function handleModuleMessage( msg : String ) {
        trace( msg );
    }

    static function main() {

        window.onload = function(_){

            module = om.nacl.Module.create( 'hello' );
            module.onLoad = handleModuleLoad;
            module.onMessage = handleModuleMessage;
            document.body.appendChild( module.element );

            /*
            module = new om.nacl.ModuleElement( 'hello' );
            module.onLoad( handleModuleLoad );
            //module.onMessage = handleModuleMessage;
            document.body.appendChild( module );
            */
        }
    }
}
