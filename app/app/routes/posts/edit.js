import Ember from 'ember';

export default Ember.Route.extend({
  deactivate: function() {
    var model = this.modelFor('posts/edit');
    model.rollback();
  }
});
