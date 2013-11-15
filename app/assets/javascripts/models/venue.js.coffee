# for more details see: http://emberjs.com/guides/models/defining-models/

PrimaApp.Venue = DS.Model.extend
  title: DS.attr 'string'
  body: DS.attr 'string'