"use babel";

import { CompositeDisposable } from "atom";

let oPackageConfig, fActivate, fDeactivate, oDisposables;

oPackageConfig = {
    "trim-before": {
        "title": "Trim before wrap & pad",
        "description": "Trim the selection before applying the wrap & pad action.",
        "type": "boolean",
        "default": false
    },
    "pairs": {
        "type": "array",
        "default": [
            {
                "name": "parenthesis",
                "start": "(",
                "pad": " ",
                "end": ")"
            },
            {
                "name": "brackets",
                "start": "[",
                "pad": " ",
                "end": "]"
            },
            {
                "name": "curly-brackets",
                "start": "{",
                "pad": " ",
                "end": "}"
            }
        ],
        "items": {
            "type": "object"
        }
    }
};

fActivate = function() {

    atom.config.observe( "wrap-and-pad", ( oConfig ) => {
        let bTrimBefore = oConfig[ "trim-before" ];

        oDisposables && oDisposables.dispose();
        oDisposables = new CompositeDisposable();

        oConfig.pairs.forEach( ( { name, start, pad, end } ) => {
            oDisposables.add( atom.commands.add( "atom-text-editor:not([mini])", `wrap-and-pad:wrap-and-pad-with-${ name }`, () => {
                let oEditor;

                ( oEditor = atom.workspace.getActiveTextEditor() ).transact( () => {
                    for ( let oSelection of oEditor.selections ) {
                        let sText = oSelection.getText();

                        if ( bTrimBefore ) {
                            sText = sText.trim();
                        }
                        oSelection.insertText( `${ start }${ pad }${ sText }${ pad }${ end }` );
                    }
                } );
            } ) );
        } );
    } );

};

fDeactivate = function() {
    oDisposables.dispose();
};

export {
    oPackageConfig as config,
    fActivate as activate,
    fDeactivate as deactivate
};
