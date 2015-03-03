import Ember from 'ember';
import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin';

export default Ember.Route.extend(AuthenticatedRouteMixin, {
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
