require "rails_helper"

RSpec.describe "Avatar Service" do
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
  it 'can get all characters' do
    response = AvatarService.get_characters('fire+nation')

    expect(response).to be_an(Array)
    expect(response.first).to be_a(Hash)
    expect(response.first).to have_key(:_id)
    expect(response.first).to have_key(:allies)
    expect(response.first).to have_key(:enemies)
    expect(response.first).to have_key(:photoUrl)
    expect(response.first).to have_key(:name)
    expect(response.first).to have_key(:affiliation)

    total = response.each do |character|
      Character.new(character)
    end

    expect(total.count).to eq(20)
  end

  it 'can get the first 25 characters' do
    response = AvatarService.get_first_25_characters('fire+nation')

    expect(response).to be_an(Array)
    expect(response.first).to be_a(Hash)
    expect(response.first).to have_key(:_id)
    expect(response.first).to have_key(:allies)
    expect(response.first).to have_key(:enemies)
    expect(response.first).to have_key(:photoUrl)
    expect(response.first).to have_key(:name)
    expect(response.first).to have_key(:affiliation)

    total = response.each do |character|
      Character.new(character)
    end

    expect(total.count).to eq(25)
  end
end