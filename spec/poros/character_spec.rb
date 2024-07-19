require "rails_helper"

RSpec.describe "Character Poro" do
  it 'can create a character poro' do
    json = [
      {
          "_id": "5cf5679a915ecad153ab68ef",
          "allies": [
              "Azula"
          ],
          "enemies": [
              "Sokka"
          ],
          "photoUrl": "https://vignette.wikia.nocookie.net/avatar/images/0/02/Bully_guard.png/revision/latest?cb=20120702232626",
          "name": "Bully guard",
          "affiliation": "Fire Nation"
      }
    ]

    character = Character.new(json.first)

    expect(character).to be_a Character
    expect(character.name).to eq("Bully guard")
    expect(character.allies).to eq(["Azula"])
    expect(character.enemies).to eq(["Sokka"])
    expect(character.affiliations).to eq("Fire Nation")
    expect(character.picture).to eq("https://vignette.wikia.nocookie.net/avatar/images/0/02/Bully_guard.png/revision/latest?cb=20120702232626")
  end
end