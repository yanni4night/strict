assert = require "assert"

Strict =
    reservedWords: () ->
        "use strict"
        reservedWords = ["implements", "interface", "let", "package", "private", "protected", "public", "static", "yield"];
        reservedWords.forEach (word)->
            assert.throws (() -> eval('var ' + word + '=1;')), word + ' is reserved word'
    octal: () ->
        assert.throws (() -> eval('"use strict";var s=045;')), 'octal expression is not allowd'


for e of Strict
    Strict[e]()

module.exports = Strict