$(document).ready(function(){


ArtistSearch.Views.AlbumView = Backbone.View.extend({
  tagName: 'div',
  className:  'album-box',
  template: _.template($('#album-template').html()),
  events: {
            'click .album-pic': 'seeDetails'
          },
  render: function(){
    this.$el.html(this.template({data: this.model.toJSON()}));
    return this;
  },
  seeDetails: function(){
    $('.overlay').show();
    new ArtistSearch.Views.InfoView({model: this.model}).render();
  }
});



ArtistSearch.Views.AlbumsView = Backbone.View.extend({
  el: '#album-container',
  initialize: function(){
    this.listenTo(this.collection, 'add', this.render);
    this.render();
  },
  render: function(){
    this.$el.html('');
    this.collection.each(function(album){
      this.$el.append(new ArtistSearch.Views.AlbumView({model: album}).render().$el);
    }.bind(this));
  }
});

ArtistSearch.Views.InfoView = Backbone.View.extend({
  tagName: 'div',
  className:  'songs-info',
  template: _.template($('#info-template').html()),
  events: {
            'click .title': 'closeDetails'
          },
  render: function(){
    this.$el.html(this.template({info: this.model.toJSON()})).appendTo($('body')).show();
    return this;
  },
  closeDetails: function(){
    $(this.el).remove();
    $('.overlay').hide()
  }
});


ArtistSearch.Views.SearchView = Backbone.View.extend({
  el: '.search-bar',
  events: {
    'click #search': 'searchSongs',
    'keyup #search-input': 'searchSongs'
  },
  searchSongs: function(e){
    if(e.keyCode == 13 || e.type =='click'){
      var query = this.$('input').val();
      var albums = new ArtistSearch.Collections.Albums([], { query: query});
      albums.fetch({
        success: function(albums){
          new ArtistSearch.Views.AlbumsView({collection: albums});
        }
      });
    }
  }
});

new ArtistSearch.Views.SearchView
});
