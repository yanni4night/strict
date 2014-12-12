assert = require "assert"

Strict =
    reservedWords: () ->
        "use strict"
        reservedWords = ["implements", "interface", "let", "package", "private", "protected", "public", "static", "yield"];
        reservedWords.forEach (word)->
            assert.throws (() -> eval('var ' + word + ' = 1;')), word + ' is reserved word'
    octal: () ->
        assert.throws (() -> eval('"use strict";var s = 045;')), 'octal expression is not allowd'
    assignment: () ->
        "use strict"
        assert.throws (() -> eval('undeclared = 1')), 'assignment to an undeclared identifier'
        
        ['NaN', 'undefined', 'Infinity'].forEach (v) ->
            assert.throws (() -> eval('"use strict";' + v + ' = 1')), 'assignment to ' + v

        obj = {}
        Object.defineProperties obj,
            'name':
                value: 'yanni'
                writable: false
            'age':
                get: (n) ->
                    this.age = n
        Object.preventExtensions obj
        assert.throws (() -> obj.name = 1), 'assignment to unwritable'
        assert.throws (() -> obj.age = 22 ), 'assignment a unsettable'
        assert.throws (() -> obj.newV = 0 ), 'add a new property'




for e of Strict
    Strict[e]()

module.exports = Strict