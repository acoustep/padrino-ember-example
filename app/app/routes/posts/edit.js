import Ember from 'ember';

export default Ember.Route.extend({
  deactivate: function() {
    var model = this.modelFor('posts/edit');
    model.rollback();
  },
  actions: {
    save: function() {
      var _this = this;
      this.modelFor('posts/edit').save().then(function() {
        _this.transitionTo('posts.index');
      });
    }
  }
});
