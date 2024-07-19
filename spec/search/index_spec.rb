require "rails_helper"

RSpec.describe "Search Index Page", type: :feature do
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
  it 'has a shows character and nation details' do
    visit root_path

    select 'Fire Nation', from: 'nation'

    click_button 'Search For Members'

    expect(current_path).to eq(search_path)
    
    within("#nation_details") do
      expect(page).to have_content("Nation: Fire Nation")
      expect(page).to have_content("Population: 20")
    end

    within("#character_1") do
      expect(page).to have_content("Name: Bully guard")
      expect(page).to have_content("Affiliations: Fire Nation")
      expect(page).to have_css("img[src='https://vignette.wikia.nocookie.net/avatar/images/0/02/Bully_guard.png/revision/latest?cb=20120702232626']")
      within("#allies") do
        expect(page).to have_content("Azula")
      end
      within("#enemies") do
        expect(page).to have_content("Sokka")
      end
    end

    within("#characters") do
      expect(page).to have_css("#character_1")
      expect(page).to have_css("#character_25")
      expect(page).to_not have_css("#character_26")
    end
  end
  # need to remove allies and enemies from a character and test sad path empty array
end