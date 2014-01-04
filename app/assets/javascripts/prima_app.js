//= require ./store
//= require_tree ./models
//= require_tree ./controllers
//= require_tree ./views
//= require_tree ./helpers
//=  require_tree ./components
//= require_tree ./templates
//= require_tree ./routes
//= require ./router
//= require_self


// initializer for emberSimpleAuth
Ember.Application.initializer({
  name: 'authentication',
  initialize: function(container, application) {
    Ember.SimpleAuth.setup(container, application);
  }
});



  // use the provided mixin in the application route
  PrimaApp.ApplicationRoute = Ember.Route.extend(Ember.SimpleAuth.ApplicationRouteMixin, {
    actions: {
      login: function() {
        // open a new window that displays the Facebook login dialog; see the callback handler on the server side
        // (get '/7-external-oauth/callback') in the runner file
        window.open(
          'https://www.facebook.com/dialog/oauth?client_id=1417372111822319&redirect_uri=http://localhost:3000/',
          '_blank',
          'menubar=no,status=no,height=400,width=800'
        );
      },
      // set the application controller's error messages when the login fails so it gets displayed
      // in the application template (see tempate above)
      loginFailed: function(error) {
        this.controllerFor('application').set('loginErrorMessage', 'The login failed!');
      },
      // clear the error message when the login succeeds (must call _super here to make sure an aborted
      // transition is retried etc.)
      loginSucceeded: function() {
        this._super();
        this.controllerFor('application').set('loginErrorMessage', undefined);
      }
    }
  });



PrimaApp.Venue = DS.Model.extend({
  title: DS.attr("string"),
  body: DS.attr("string"),
  posts: DS.hasMany('PrimaApp.Post')
});



PrimaApp.Post = DS.Model.extend({
  content: DS.attr("string"),
  venue: DS.belongsTo('PrimaApp.Venue')
});




PrimaApp.IndexRoute = Ember.Route.extend({
  redirect: function() {
    return this.transitionTo("home");
  }
});

PrimaApp.MainRoute = Ember.Route.extend({
  redirect: function() {
    return this.transitionTo("venues");
  }
});


PrimaApp.RatyView = Ember.View.extend({
  didInsertElement: function() {

var id=this.get('context').get('id');

	$('#star_'+id).raty({
		readOnly: true,
		score: 3,
								  
		path: '/assets'
	});
   
     
   
  }
});
