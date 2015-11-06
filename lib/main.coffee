{ CompositeDisposable } = require "atom"

module.exports =
    config:
        "trim-before":
            title: "Trim before wrap & pad"
            description: "Trim the selection before applying the wrap & pad action."
            type: "boolean"
            default: no
        pairs:
            type: "array"
            default: [
                    name: "parenthesis"
                    start: "("
                    pad: " "
                    end: ")"
                ,
                    name: "brackets"
                    start: "["
                    pad: " "
                    end: "]"
                ,
                    name: "curly-brackets"
                    start: "{"
                    pad: " "
                    end: "}"
            ]
            items:
                type: "object"

    activate: ->
        atom.config.observe "wrap-and-pad", ( oConfig ) ->
            @disposables.dispose() if @disposables?
            @disposables = new CompositeDisposable()

            bTrimBefore = oConfig[ "trim-before" ]

            oConfig.pairs.forEach ( { name, start, pad, end } ) ->
                oCommand = atom.commands.add "atom-text-editor:not([mini])", "wrap-and-pad:wrap-and-pad-with-#{ name }", ->
                    ( oEditor = atom.workspace.getActiveTextEditor() ).transact ->
                        oEditor.selections.forEach ( oSelection ) ->
                            sText = oSelection.getText()
                            sText = sText.trim() if bTrimBefore
                            oSelection.insertText "#{ start }#{ pad }#{ sText }#{ pad }#{ end }"
                @disposables.add oCommand

    deactivate: ->
        @disposables.dispose()
