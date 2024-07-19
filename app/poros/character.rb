class Character
  
  def initialize(data)
    @name = data[:name]
    @allies = data[:allies]
    @enemies = data[:enemies]
    @affiliation = data[:affiliation]
    @picture = data[:photoUrl]
  end
end