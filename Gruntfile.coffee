module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    coffee:
      glob_to_multiple:
        expand: true
        cwd: 'src'
        src: ['**/*.coffee']
        dest: 'lib'
        ext: '.js'

    coffeelint:
      options:
        no_empty_param_list:
          level: 'error'
        max_line_length:
          level: 'ignore'
        indentation:
          level: 'ignore'

      src: ['src/*.coffee']
      test: ['spec/*.coffee']
      gruntfile: ['Gruntfile.coffee']

    shell:
      'test-with-native-weakmap':
        command: 'node --harmony_collections node_modules/jasmine-focused/bin/jasmine-focused --coffee --captureExceptions spec'
        options:
          stdout: true
          stderr: true
          failOnError: true
      'test-with-weakmap-module':
        command: 'node node_modules/jasmine-focused/bin/jasmine-focused --coffee --captureExceptions spec'
        options:
          stdout: true
          stderr: true
          failOnError: true

  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-shell')
  grunt.loadNpmTasks('grunt-coffeelint')

  grunt.registerTask 'clean', -> require('rimraf').sync('lib')
  grunt.registerTask('lint', ['coffeelint'])
  grunt.registerTask('default', ['coffee', 'lint'])
  grunt.registerTask('test', ['coffee', 'lint', 'shell:test-with-native-weakmap', 'shell:test-with-weakmap-module'])
