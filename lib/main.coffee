{ CompositeDisposable } = require "atom"

module.exports =
    config:
        pairs:
            type: "object"
            properties:
                "parenthesis":
                    type: "object"
                    properties:
                        start:
                            type: "string"
                            default: "("
                        pad:
                            type: "string"
                            default: " "
                        end:
                            type: "string"
                            default: ")"
                "brackets":
                    type: "object"
                    properties:
                        start:
                            type: "string"
                            default: "["
                        pad:
                            type: "string"
                            default: " "
                        end:
                            type: "string"
                            default: "]"
                "curly-brackets":
                    type: "object"
                    properties:
                        start:
                            type: "string"
                            default: "{"
                        pad:
                            type: "string"
                            default: " "
                        end:
                            type: "string"
                            default: "}"

    activate: ->
        atom.config.observe "wrap-and-pad", ( oConfig ) ->
            @disposables.dispose() if @disposables?
            @disposables = new CompositeDisposable()

            for sPairName, oPairInfos of oConfig.pairs
                oCommand = do ( sPairName, oPairInfos ) ->
                    atom.commands.add "atom-text-editor:not([mini])", "wrap-and-pad:wrap-and-pad-with-#{ sPairName }", ->
                        ( oEditor = atom.workspace.getActiveTextEditor() ).transact ->
                            oEditor.selections.forEach ( oSelection ) ->
                                sText = oSelection.getText()
                                oSelection.insertText "#{ oPairInfos.start }#{ oPairInfos.pad }#{ sText }#{ oPairInfos.pad }#{ oPairInfos.end }"
                @disposables.add oCommand

    deactivate: ->
        @disposables.dispose()
