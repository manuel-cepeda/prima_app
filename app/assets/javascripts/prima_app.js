//= require ./store
//= require_tree ./models
//= require_tree ./controllers
//= require_tree ./views
//= require_tree ./helpers
//= require_tree ./components
//= require_tree ./templates
//= require_tree ./routes
//= require ./router
//= require_self


// initializer for emberSimpleAuth


  Ember.Application.initializer({
    name: 'authentication',
    initialize: function(container, application) {


      Ember.SimpleAuth.Session.reopen({
        init: function() {

          this._super();

          //initializer the accountId from data potentially already present in a
          //session cookie (Ember.SimpleAuth.Session does this out of the box for authToken)
          var accountId = (document.cookie.match(/accountId=([^;]+)/) || [])[1];

          
          this.set('accountId', accountId);
          this.set('account', container.lookup('store:main').find('user', this.get('accountId')));

        },
        setup: function(serverSession) {
          this._super(serverSession);
          that=this;

          return $.getJSON("/api/v1/account").then(

            function(response) {
              

               var obj = JSON.parse(JSON.stringify(response));
               document.cookie = 'accountId='+obj.user_id;
               that.set('accountId', obj.user_id);

                return response;


            }
          );

          
        },
        destroy: function() {
          this._super();
          this.set('accountId', undefined);
        },
        accountIdChanged: function() {
          //save accountId in a session cookie so it survives a page reload (Ember.SimpleAuth.Session
          //does this out of the box for authToken)
          document.cookie = 'accountId=' + this.get('accountId');
          this.set('account', container.lookup('store:main').find('user', accountId));
        }.observes('accountId'),
        account: function() {
          var accountId = this.get('accountId');


          if (!Ember.isEmpty(accountId)) {
            this.set('account', container.lookup('store:main').find('user', accountId));
          }
        }.property('accountId'),


      });





      Ember.SimpleAuth.setup(container, application, {
        routeAfterLogin: 'venues',
        routeAfterLogout: 'venues'
      });

    }
  });



  // use the provided mixin in the application route
  PrimaApp.ApplicationRoute = Ember.Route.extend(Ember.SimpleAuth.ApplicationRouteMixin, {
    actions: {
      login: function() {
        // open a new window that displays the Facebook login dialog; see the callback handler on the server side
        // (get '/7-external-oauth/callback') in the runner file
        //change for development: 
        // https://www.facebook.com/dialog/oauth?client_id=1417372111822319&scope=email,publish_stream&redirect_uri=http://localhost:3000/auth/facebook/callback
        window.open(
          'https://www.facebook.com/dialog/oauth?client_id=708728955810882&scope=email,publish_stream&redirect_uri=http://www.krowdly.com/auth/facebook/callback',
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
        
        //refresh user 
     //   this.store.find('user', 2).reload();
     //   this.controllerFor('application').set('userInfo', PrimaApp.User.find(user_id));
        //this.store.find('user', 'me').reload();

      },
      logout: function() {

        this._super();

      }



    }
  });



PrimaApp.Venue = DS.Model.extend({
  title: DS.attr("string"),
  body: DS.attr("string"),
  latitude: DS.attr("string"),
  longitude: DS.attr("string"),
  posts: DS.hasMany('PrimaApp.Post'),
  ratings: DS.hasMany('PrimaApp.Rating'),
  user: DS.belongsTo('PrimaApp.User'),
  score: function(){
        var ratings = this.get("ratings");
        var sum=0;
        var count=0;

        sum = ratings.reduce(function(previousValue, rating){
            return previousValue + parseInt(rating.get("score"));    
        }, 0);

     
     if(ratings.get('length')==0){
        count=1;
     }else{
      count=ratings.get('length');
     }


        return sum/count;

    }.property("ratings.@each.score"),
  totalCount: function () {
      var posts= this.get('posts');
      return posts.get('length');
  }.property('posts.@each')    

});



PrimaApp.Post = DS.Model.extend({
  content: DS.attr("string"),
  venue: DS.belongsTo('PrimaApp.Venue'),
  created_at: DS.attr("date"),
  user: DS.belongsTo('PrimaApp.User'),
});


PrimaApp.Feedback = DS.Model.extend({
  description: DS.attr("string"),

});


PrimaApp.User = DS.Model.extend({
  name: DS.attr("string"),
  fb_id: DS.attr("string"),
  posts: DS.hasMany('PrimaApp.Post'),
  venues: DS.hasMany('PrimaApp.Venue'),
  ratings: DS.hasMany('PrimaApp.Rating'),
  totalPostCount: function () {
      var posts= this.get('posts');
      return posts.get('length');
  }.property('posts.@each'),
  totalRatingCount: function () {
      var ratings= this.get('ratings');
      return ratings.get('length');
  }.property('ratings.@each')  
  
});

PrimaApp.Rating = DS.Model.extend({
  score: DS.attr("string"),
  venue: DS.belongsTo('PrimaApp.Venue'),
  user: DS.belongsTo('PrimaApp.User')
});






PrimaApp.FeedbacksIndexRoute = Ember.Route.extend({
  model: function() {
    return this.store.find('feedback');
  }
});

PrimaApp.PostsRoute = Ember.Route.extend({
  model: function() {
    return this.store.find('post');
  }
});


PrimaApp.VenuesIndexRoute = Ember.Route.extend({
  model: function() {
    return this.store.find('venue');
  },

});


PrimaApp.FeedbacksNewRoute = Ember.Route.extend({
  model: function() {

    return PrimaApp.Feedback.createRecord({});
  }
});


PrimaApp.VenuesNewRoute = Ember.Route.extend({
  model: function() {

    var account = this.get('session').get('account');

    return PrimaApp.Venue.createRecord({
      user: account
    });


  }
});


PrimaApp.VenuesEditRoute = Ember.Route.extend({
  model: function(params) {
    return {id: params.venue_id};
  },
  setupController: function(controller, model) {
    var venue_model = PrimaApp.Venue.find(model.id);
    controller.set("content", venue_model);
  }
});



PrimaApp.PostsNewRoute = Ember.Route.extend({
  model: function() {
    return PrimaApp.Post.createRecord({});
  }
});



PrimaApp.IndexRoute = Ember.Route.extend({
  redirect: function() {
    return this.transitionTo("home");
  }
});






PrimaApp.Searcher = {
  findByQuery: function(query) {

 return PrimaApp.Venue.find({ query: query });


  }
};
PrimaApp.SearchRoute = Ember.Route.extend({
    model : function (params) {
        return params;
    },
   setupController: function(controller,model) {
    var query = model.query;
     controller.set('model',PrimaApp.Searcher.findByQuery(query));
  }
});

PrimaApp.SearchController = Ember.ArrayController.extend({
    onChangeQuery : function () {

     
        var query = this.get("query");
        this.transitionToRoute("search", {query  : query});
    }.observes("query")
});



PrimaApp.MainController = Ember.ObjectController.extend({
    query: '',
    actions: {


          executeQuery : function () {

              var query = this.get("query");

              this.transitionTo("search", {query  : query});
          }

    }

});







PrimaApp.FeedbacksNewController = Ember.ObjectController.extend({


  transitionAfterSave: (function() {
    if (this.get('content.id')) {
      return this.transitionToRoute('feedback', this.get('content'));
    }
  }).observes('content.id'),


actions: {

  save: function() {
    return this.get('store').commit();
  },
  cancel: function() {
    this.get('content').deleteRecord();
    this.get('store').transaction().rollback();
    return this.transitionToRoute('feedbacks');
  }

 }

});

PrimaApp.VenuesIndexController = Ember.ArrayController.extend({
  itemController: 'venue',
  sortProperties: ["score"],
  sortAscending: false,
  actions: {
    query: function() {
      // the current value of the text field
      var query = this.get('search');
      this.transitionToRoute('venues.search', { query: query });
    }
  }
});




PrimaApp.PostController = Ember.ObjectController.extend({

  transitionAfterSave: (function() {

   // alert(this.get('content').get('venue').get('id'));
    if (this.get('content.id')) {
      return this.transitionToRoute('venue', this.get('content').get('venue').get('id'));
    }
  }).observes('content.id'),

});


PrimaApp.VenueController = Ember.ObjectController.extend({
 needs: ['application'],
 posts: Ember.computed.alias("controllers.posts"),
 fbId:null,
 posts: (function() {
        return Ember.ArrayProxy.createWithMixins(Ember.SortableMixin, {
          sortProperties: ['id'],
          sortAscending: false,
          content: this.get('content.posts')
        })
  }).property('content.posts'),


actions: {

    removeVenue: function() {
        if (window.confirm("¿Seguro que quieres eliminar este lugar?")) {
          this.get('content').deleteRecord();
          this.get('store').commit();
          return this.transitionToRoute('venues');
        }
      },  


    savePost: function () {

      var store= this.get('store');
      var newContent = this.get('newContent');

      if (!newContent) {
        return;
      }     

      // Create the new Todo model
      var post = PrimaApp.Post.createRecord({
        content: newContent,
        venue: store.find('venue', this.get("id")),
        user: this.get('session').get('account')
      });


      this.set('newContent', '');

      //transition to update after save ordered by id
      var self = this;
      post.save();


    },

  removePost: function (post) {

    post.deleteRecord();
    post.save();
  },




 } 

});





PrimaApp.ApplicationView = Ember.View.extend({
    didInsertElement : function(){
        var that = this;

        
        Ember.run.next(function(){
       
           that.$(".menu-item").click(function(e) {
               that.$(".meanmenu-reveal").click();
           });
        });
    }
});



PrimaApp.RatyView = Ember.View.extend({
  didInsertElement: function() {

 

            var id=this.get('context').get('id');
            $('#star_'+id).raty({
              readOnly: true,
              score: this.get('context').get('score'),
                            
              path: '/assets'
            });   
  }
});



PrimaApp.SeeView = Ember.View.extend({
  actions:{
    daClick: function(){

      this.get('controller')
      .transitionToRoute('venue',
       this.get('context').get('id'));
  
    }
  }
});

PrimaApp.MapView = Ember.View.extend({
  actions:{
    mapClick: function(){


          lat=this.get('context').get('latitude');
          lng=this.get('context').get('longitude');

          initialize(lat,lng);
         
       
  
    }
  }
});



PrimaApp.VenuesNewController = Ember.ObjectController.extend({


  transitionAfterSave: (function() {
    if (this.get('content.id')) {
      return this.transitionToRoute('venue', this.get('content'));
    }
  }).observes('content.id'),


actions: {

  save: function() {

    if(this.get('title')){

      return this.get('store').commit();

    }else{

      return null;
    }
    
  },

 }

});

PrimaApp.VenuesEditController = Ember.ObjectController.extend({



actions: {

  save: function() {
    this.get('store').commit();
     return this.transitionToRoute('venue', this.get('content'));
  },

 }

});





PrimaApp.MapSaveView = Ember.View.extend({

  didInsertElement: function() {

 lat=this.get('controller').get('latitude');
 lng=this.get('controller').get('longitude');

    if(lat&&lng){
      //edit venue case
      initialize(lat,lng);
    }else{

      //do nothing because is a new venue
    }

  },


  actions:{


    geolocalize: function(){

var that=this;

            if(navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(function(position){

                  that.get('controller').set('latitude',position.coords.latitude);
                  that.get('controller').set('longitude',position.coords.longitude);


               //  this.set('latitude',position.coords.latitude);
                    initialize(position.coords.latitude,position.coords.longitude);
                });
            }
    },

  }


});



PrimaApp.RatingView = Ember.View.extend({



  didInsertElement: function() {

        var that = this;

  
        Ember.run.next(function(){



        score= that.get('context').get('score');

              $('#star').raty({
                readOnly: true,
                score: score,
                path: '/assets/mini'
              });

              $('#user_star').raty({
                score: score,
                width:250,
                path: '/assets',
                click: function(score, evt) {

                      var store = that.get('context').get('store');
                      var venueId = that.get('context').get("id");
                      var userId = that.get('context').get('session').get('account').get('id');


                        var rate= PrimaApp.Rating.createRecord({
                        score: score,
                        venue: store.find('venue', venueId),
                        user:  store.find('user', userId)
                      });


                        rate.save();

                  //  alert(that.get('controller.model.ratings'));
                    set_score_comment(score);


                }
              });

        });


  
  }
});



PrimaApp.RatingUserView = Ember.View.extend({
  didInsertElement: function() {

        var that = this;

        score= that.get('context').get('score');       
        Ember.run.next(function(){

 
             set_score_comment(score);

 


        });


  
  }
});


PrimaApp.FacebookImageView = Ember.View.extend({

  attributeBindings: ['src', 'alt', 'elementId'],
  elementId: 'photo-comment',
  src: null,
  alt: 'avatar',
  tagName: 'img',

  didInsertElement: function() {
        that=this;

       PrimaApp.User.find(that.get('context').get('userId')).then(function(model) {

            that.set('src', 'https://graph.facebook.com/'+model.get('fb_id')+'/picture?width=80&height=80');

          }); 

  }
});


Ember.Handlebars.helper('format-date', function(date){

  return moment(date).fromNow();
});


Ember.Handlebars.helper('profile-picture', function(value, options) {
  var escaped = Handlebars.Utils.escapeExpression(value);
  return new Handlebars.SafeString('<img alt="avatar" id="photo-comment" src="https://graph.facebook.com/'+value+'/picture?width=80&amp;height=80">');
});

Handlebars.registerHelper('ifCond', function(v1, v2, options) {

    var obj1 = Ember.get(this, v1);
    var obj2 = Ember.get(this, v2);
    var var1 = obj1.get("id");
    var var2 = obj2.get("id");
   


  if(var1 === var2) {
    return options.fn(this);
  }
  return options.inverse(this);
});





 function set_score_comment(score_value) {

     switch (score_value) {
         case (1):
          $('#vote-message').text('Aburrido como ostra');
         break;
         case (2):
          $('#vote-message').text('Prefiero contar ovejas');
         break;
         case (3):
          $('#vote-message').text('Está que prende');
         break;
         case (4):
          $('#vote-message').text('Tan bueno que me quemo');
         break;
         case (5):
          $('#vote-message').text('¡Traigan agua que está en llamas!');
         break;
         default:
          $('#vote-message').text('Si estás en este lugar, vota!');
      }


 }

    function initialize(lat,lng){


          lat=lat;
          lng=lng;

          var myOptions = {
            zoom: 6,

            zoomControl: true,
            zoomControlOptions: {
                style: google.maps.ZoomControlStyle.SMALL,
                position: google.maps.ControlPosition.LEFT_CENTER
            },

            scaleControl: true,
            panControl: true,
            navigationControl: false,              
            mapTypeId: 'roadmap',
            streetViewControl: true,
            center: new google.maps.LatLng(lat, lng)
         }         

            document.getElementById('map-canvas').style.display = "";


             // This is the minimum zoom level that we'll allow
             var minZoomLevel = 15;
             var latlng = new google.maps.LatLng(lat, lng);
             var map = new google.maps.Map(document.getElementById('map-canvas'), myOptions);

            var marker = new google.maps.Marker({
                position: latlng,
                map: map,
                title:"You are here!"
            });

            


    }
