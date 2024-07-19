class SearchController < ApplicationController
  def index
    @nation = params[:nation]
    @characters = AvatarFacade.get_characters(@nation)
    @first_25_characters = AvatarFacade.get_first_25_characters(@nation)
  end
end