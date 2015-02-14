import Ember from 'ember';

export default Ember.Route.extend({
  model: function() {
    return this.store.createRecord('post');
  },
  deactivate: function() {
    var model = this.modelFor('posts/new');

    if(model.get('isNew')) {
      model.destroyRecord();
    }
  },
  actions: {
    save: function() {
      var _this = this;
      this.modelFor('posts/new').save().then(function() {
        _this.transitionTo('posts.index');
      });
    }
  }
});
