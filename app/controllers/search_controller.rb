class SearchController < ApplicationController
  def index
    @nation = params[:nation]
    @characters = AvatarFacade.get_characters(@nation)
  end
end