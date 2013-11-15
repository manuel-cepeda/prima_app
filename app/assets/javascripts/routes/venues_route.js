PrimaApp.VenuesRoute = Ember.Route.extend({
  model: function() {
    return PrimaApp.Venue.find();
  }
});