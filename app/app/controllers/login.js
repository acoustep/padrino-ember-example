// app/controllers/login.js
import LoginControllerMixin from 'simple-auth/mixins/login-controller-mixin';
import Ember from 'ember';

export default Ember.Controller.extend(LoginControllerMixin, {
  authenticator: 'simple-auth-authenticator:devise',
  actions: {
    // display an error when authentication fails
    authenticate: function() {
      var _this = this;
      this._super().then(null, function(error) {
        _this.set('errorMessage', error.message);
      });
    }
  }
});
