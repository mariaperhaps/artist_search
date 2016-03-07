ArtistSearch.Models.Album = Backbone.Model.extend({});


ArtistSearch.Collections.Albums = Backbone.Collection.extend({
  model: ArtistSearch.Models.Album,
  initialize: function(models, options) {
    this.query = options.query;
  },
  url: function(){
   return "http://localhost:3000/artists?q=" + this.query
  },
  parse: function(response){
    return  response
  }
});
