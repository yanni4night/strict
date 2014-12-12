assert = require "assert"

Strict =
    reservedWords: () ->
        "use strict"
        reservedWords = ["implements", "interface", "let", "package", "private", "protected", "public", "static", "yield"];
        reservedWords.forEach (word)->
            assert.throws (() -> eval('var ' + word + '=1;')), word + ' is reserved word'
            
            


for e of Strict
    Strict[e]()

module.exports = Strict