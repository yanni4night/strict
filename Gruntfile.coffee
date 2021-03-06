module.exports = (grunt)->
    (require 'time-grunt') grunt
    (require 'load-grunt-tasks') grunt
    grunt.initConfig
        coffee:
            cases:
                expand: true
                cwd: '.'
                src: ['strict.coffee']
                dest: '.'
                ext: '.js'
        watch:
            cs:
                files: ['strict.coffee']
                tasks: ['default']
        shell:
            test:
                command: 'node strict.js'
        coffeelint:
            options:
                configFile: '.coffeelintrc'
            all: ['*.coffee']

    grunt.registerTask 'test', ['coffee', 'shell']
    grunt.registerTask 'default', ['coffeelint', 'test']