import Ember from 'ember';
import { Bindings } from 'ember-pusher/bindings';

export default Ember.ArrayController.extend(Bindings, {
  sortProperties: ['createdAt'],
  sortAscending: false,
  logPusherEvents: true,
  PUSHER_SUBSCRIPTIONS: {
    posts: ['new-post']
  },
  actions: {
    newPost: function(message) {
      var _this = this;
      Ember.run.later((function() {
        _this.store.push('post', _this.store.normalize('post', message.post));
      }), 2000);
    }
  }
});
