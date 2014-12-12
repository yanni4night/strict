#http://www.ecma-international.org/ecma-262/5.1/#sec-C
assert = require "assert"

Strict =
    #The identifiers "implements", "interface", "let", "package", "private", "protected", "public", "static", and "yield" are classified as FutureReservedWord tokens within strict mode code. (7.6.12).
    reservedWords: () ->
        "use strict"
        reservedWords = ["implements", "interface", "let", "package", "private", "protected", "public", "static", "yield"];
        reservedWords.forEach (word)->
            assert.throws (() -> eval('var ' + word + ' = 1;')), word + ' is reserved word'
    #A conforming implementation, when processing strict mode code, may not extend the syntax of NumericLiteral (7.8.3) to include OctalIntegerLiteral as described in B.1.1.
    #A conforming implementation, when processing strict mode code (see 10.1.1), may not extend the syntax of EscapeSequence to include OctalEscapeSequence as described in B.1.2.
    octal: () ->
        assert.throws (() -> eval('"use strict";var s = 045;')), 'octal expression is not allowd'
    #Assignment to an undeclared identifier or otherwise unresolvable reference does not create a property in the global object. When a simple assignment occurs within strict mode code, its LeftHandSide must not evaluate to an unresolvable Reference. If it does a ReferenceError exception is thrown (8.7.2). The LeftHandSide also may not be a reference to a data property with the attribute value {[[Writable]]:false}, to an accessor property with the attribute value {[[Set]]:undefined}, nor to a non-existent property of an object whose [[Extensible]] internal property has the value false. In these cases a TypeError exception is thrown (11.13.1).
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
    #The identifier eval or arguments may not appear as the LeftHandSideExpression of an Assignment operator (11.13) or of a PostfixExpression (11.3) or as the UnaryExpression operated upon by a Prefix Increment (11.4.4) or a Prefix Decrement (11.4.5) operator.
    evalArguments: () ->
        "use strict"
        assert.throws (() -> eval('eval = 1')), 'assignment to "eval"'        
        assert.throws (() -> eval('arguments = 1')), 'assignment to "arguments"'
        assert.throws (() -> eval('eval++') ), 'increment/decrement "eval"'
        assert.throws (() -> eval('arguments++') ), 'increment/decrement "arguments"'
        assert.throws (() -> eval('++eval') ), 'prefix increment/decrement "eval"'
        assert.throws (() -> eval('++arguments') ), 'prefix increment/decrement "arguments"'
    #Arguments objects for strict mode functions define non-configurable accessor properties named "caller" and "callee" which throw a TypeError exception on access (10.6).       
    callerCallee: () ->
        "use strict"
        assert.throws (() -> eval('callerCallee.caller')), 'function.caller'
        assert.throws (() -> eval('arguments.callee')), 'arguments.callee'
    #Arguments objects for strict mode functions do not dynamically share their array indexed property values with the corresponding formal parameter bindings of their functions. (10.6).
    argumentsDynamicShare: (arg) ->
        "use strict"
        arg = 1
        assert.notEqual arguments[0], arg, 'arguments do not dynamically share'
    #For strict mode functions, if an arguments object is created the binding of the local identifier arguments to the arguments object is immutable and hence may not be the target of an assignment expression. (10.5).

    #It is a SyntaxError if strict mode code contains an ObjectLiteral with more than one definition of any data property (11.1.5).
    duplicatedProperties: () ->
        "use strict"
        assert.throws (() -> eval('{a:1,a:2}')), 'duplicated properties'
    #It is a SyntaxError if the Identifier "eval" or the Identifier "arguments" occurs as the Identifier in a PropertySetParameterList of a PropertyAssignment that is contained in strict code or if its FunctionBody is strict code (11.1.5).
    argumentsInPropertySetParameterList: () ->
        "use strict"
        assert.throws (() -> eval('var a = {set name(arguments){}}')), 'arguments in property assignment list'



for e of Strict
    Strict[e]()

module.exports = Strict