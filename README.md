# `Wrap and pad` package

> Wrap and pad selection.

This package is inspired by [gepoch/vim-surround](https://github.com/gepoch/vim-surround).

* * *

![quick demo of Wrap and pad package](https://raw.githubusercontent.com/leny/atom-wrap-and-pad/master/images/atom-wrap-and-pad.gif)

## How it works ?

**wrap-and-pad** use the configuration object to store pairs of characters, so you can add your own. Default values are :

    "wrap-and-pad":
        pairs: [
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

For each property in the `pairs` object, **wrap-and-pad** will generate a command named : `wrap-and-pad:wrap-and-pad-with-[name]`, which you can bind to any keys within your keymap file.  
By default, **wrap-and-pad** is shipped with three commands :

- `wrap-and-pad:wrap-and-pad-with-parenthesis`
- `wrap-and-pad:wrap-and-pad-with-brackets`
- `wrap-and-pad:wrap-and-pad-with-curly-brackets`

### Trim selection before wrapping

You can also trim the selection before wrapping & padding, with the `trim-before` configuration key.
