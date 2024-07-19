require "rails_helper"

RSpec.describe AvatarFacade do
  before :each do
    @fire_nation = File.read('spec/fixtures/all_by_nation_fixture.json')

    stub_request(:get, "https://last-airbender-api.fly.dev/api/v1/characters?affiliation=fire%20nation&page=1&perPage=500").
          with(
            headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Content-Type'=>'application/json',
            'User-Agent'=>'Faraday v2.9.0'
            }).
          to_return(status: 200, body: @fire_nation, headers: {})

    @first_25 = File.read('spec/fixtures/first_25_fixture.json')

    stub_request(:get, "https://last-airbender-api.fly.dev/api/v1/characters?affiliation=fire%20nation&page=1&perPage=25").
      with(
        headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'Content-Type'=>'application/json',
        'User-Agent'=>'Faraday v2.9.0'
        }).
      to_return(status: 200, body: @first_25, headers: {})
  end
  it 'can get all characters and make objects' do
    data = AvatarFacade.get_characters('fire+nation')

    expect(data).to be_an(Array)
    expect(data.first).to be_a(Character)
    expect(data.first.name).to eq("Bully guard")
    expect(data.first.affiliations).to eq("Fire Nation")
    expect(data.first.picture).to eq("https://vignette.wikia.nocookie.net/avatar/images/0/02/Bully_guard.png/revision/latest?cb=20120702232626")
    expect(data.first.allies).to eq(["Azula"])
    expect(data.first.enemies).to eq(["Sokka"])
    expect(data.count).to eq(20)
  end

  it 'can get the first 25 characters and make objects' do
    data = AvatarFacade.get_first_25_characters('fire+nation')

    expect(data).to be_an(Array)
    expect(data.first).to be_a(Character)
    expect(data.first.name).to eq("Bully guard")
    expect(data.first.affiliations).to eq("Fire Nation")
    expect(data.first.picture).to eq("https://vignette.wikia.nocookie.net/avatar/images/0/02/Bully_guard.png/revision/latest?cb=20120702232626")
    expect(data.first.allies).to eq(["Azula"])
    expect(data.first.enemies).to eq(["Sokka"])
    expect(data.count).to eq(25)
  end
end