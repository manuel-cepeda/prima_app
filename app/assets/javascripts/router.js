PrimaApp.Router.map(function() {



this.resource("home");



  this.resource("main", function() {

    this.resource("user", { path: "/users/:user_id" });

    this.resource("feedbacks", function (){
       this.resource("feedback", { path: ":feedback_id" });
       return this.route("new");


    });

    this.resource("posts", function (){
      this.resource("post", { path: ":post_id" });
      return this.route("new");

    });   

    this.resource("venues", function (){

       this.resource("venue", { path: ":venue_id"});
       this.route("new");
       this.route("edit", {
    path: "/edit/:venue_id"
  });
       
    });

    this.resource("search", {path : "/"});
    this.resource("search", {path : "/search/:query"});

  });





});



