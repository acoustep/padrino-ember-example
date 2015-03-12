import Ember from 'ember';
import { Bindings } from 'ember-pusher/bindings';

export default Ember.ArrayController.extend(Bindings, {
  sortProperties: ['id'],
  sortAscending: false,
  logPusherEvents: true,
  PUSHER_SUBSCRIPTIONS: {
    posts: ['new-post']
  },
  newPosts: [],
  newPostCount: function() {
    return this.get('newPosts').length;
  }.property('newPosts.@each'),
  newPostsExist: function() {
    return !!this.get('newPostCount');
  }.property('newPosts.@each'),
  newPostMessage: function() {
    var wording = (this.get('newPostCount') !== 1) ? "New Posts" : "New Post";
    return this.get('newPostCount') + " " + wording;
  }.property('newPosts.@each'),
  actions: {
    newPost: function(message) {
      var _this = this;
      Ember.run.later((function() {
        if(!_this.store.hasRecordForId('post', message.post.id)) {
          _this.get('newPosts').pushObject(message.post);
        }
      }), 2000);
    },
    refresh: function() {
      this.get('newPosts').forEach(function(post) {
        this.store.push('post', this.store.normalize('post', post));
      }, this);
      this.set('newPosts', []);
    }
  }
});
