PrimaApp.Router.map(function() {
  this.resource("main", function() {
    this.resource("venues", function() {});
    return this.resource("venue", {
      path: ":venue_id"
    });
  });
  return this.resource("home");
});



