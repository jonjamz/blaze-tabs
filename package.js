Package.describe({
  name: 'templates:tabs',
  summary: 'Build powerful, flexible, and reactive tabbed interfaces.',
  version: '1.0.0',
  git: 'https://github.com/meteortemplates/tabs.git'
});

Package.onUse(function(api) {
  api.versionsFrom('METEOR@1.0');
  api.use([
    'templating',
    'tracker',
    'check',
    'coffeescript'
  ], 'client');
  api.addFiles('templates:tabs.coffee');
});

Package.onTest(function(api) {
  api.use('tinytest');
  api.use('templates:tabs');
  api.addFiles('templates:tabs-tests.js');
});
