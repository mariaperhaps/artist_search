class ArtistsController < ApplicationController

  def index
    user_search = params["q"]
    results = Artist.search(user_search)

    render :json => results
  end

  private
    def artist_params
      params.permit(:q)
    end

end
