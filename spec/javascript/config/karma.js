// Contents of: config/karma.conf.js
module.exports = function (config) {
  config.set({

    basePath : '../../../',

    frameworks : ["jasmine"],

    files : [
      //libs
      'vendor/assets/javascripts/angular.js',
      'vendor/assets/javascripts/angular-*.js',
      'vendor/assets/javascripts/jquery-1.10.2.min.js',
      'vendor/assets/javascripts/underscore.js',

      //our app!
      'app/assets/javascripts/app/main.js.coffee',
      'app/assets/javascripts/app/**',

      // and our tests
      'spec/javascripts/lib/angular-mocks.js',
      'spec/javascript/unit/*.coffee'

      // mocked data
      //'spec/javascripts/<our-mini-app>/mocked-data/<data-file>.js.coffee'
    ],

    autoWatch : true,

    browsers : 'PhantomJS'.split(' '),

    preprocessors : {
      '**/*.coffee': 'coffee'
    }
  });
};
