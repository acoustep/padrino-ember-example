import Ember from 'ember';
import { Bindings } from 'ember-pusher/bindings';

export default Ember.ArrayController.extend(Bindings, {
  sortProperties: ['createdAt'],
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
      if(!this.store.hasRecordForId('post', message.post.id)) {
        this.get('newPosts').pushObject(message.post);
      }
    },
    refresh: function() {
      this.get('newPosts').forEach(function(post) {
        this.store.push('post', this.store.normalize('post', post));
      }, this);
      this.set('newPosts', []);
    }
  }
});
