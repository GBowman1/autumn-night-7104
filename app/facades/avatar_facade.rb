class AvatarFacade
  def self.get_characters(nation)
    response = AvatarService.get_characters(nation)

    response.map do |data|
      Character.new(data)
    end
  end

  def self.get_first_25_characters(nation)
    response = AvatarService.get_first_25_characters(nation)

    response.map do |data|
      Character.new(data)
    end
  end
end