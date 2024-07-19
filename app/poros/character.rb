class Character
  attr_reader :name, :allies, :enemies, :affiliations, :picture
  def initialize(data)
    @name = data[:name]
    @allies = data[:allies]
    @enemies = data[:enemies]
    @affiliations = data[:affiliation]
    @picture = data[:photoUrl]
  end

end