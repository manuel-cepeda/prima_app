PrimaApp.Router.map(function() {
  this.resource("venues", function() {
    this.resource("venue", { path: ":venue_id" });
  });
});