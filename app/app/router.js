import Ember from 'ember';
import config from './config/environment';

var Router = Ember.Router.extend({
  location: config.locationType
});

Router.map(function() {
  this.resource('posts', {path: '/'}, function() {
    this.resource('posts.new', {path: '/post/new'});
    this.resource('posts.show', {path: '/post/:post_id'});
    this.resource('posts.edit', {path: '/post/:post_id/edit'});
  });
  this.route('login');
});

export default Router;
