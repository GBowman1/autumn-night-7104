class SearchController < ApplicationController
  def index
    @nation = params[:nation]
    @characters = AvatarFacade.get_characters(@nation)  # Cant decide where the best place would be for making a characters count
    # was thinking maybe a class method and get this all characters out of the controller
    @first_25_characters = AvatarFacade.get_first_25_characters(@nation)
  end
end