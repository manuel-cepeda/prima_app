DS.RESTAdapter.reopen({
  namespace: "api/v1"
});

PrimaApp.Store = DS.Store.extend({
  revision: 12,
  adapter: DS.RESTAdapter.create()
});


