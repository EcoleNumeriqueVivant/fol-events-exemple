class MapController < ApplicationController
  def index
    @gmap = Address.all.to_gmaps4rails

  end

end
