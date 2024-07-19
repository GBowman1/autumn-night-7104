require "rails_helper"

RSpec.describe "Welcome Index Page", type: :feature do
  before :each do
    @fire_nation = File.read('spec/fixtures/all_by_nation_fixture.json')

    stub_request(:get, "https://last-airbender-api.fly.dev/api/v1/characters?affiliation=fire%20nation").
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

  it 'has a select field with the nations as options' do
    visit root_path

    expect(page).to have_select('nation', options: ['Air Nomads', 'Earth Kingdom', 'Fire Nation', 'Water Tribes'])
  end

  it 'can search for members of a nation' do
    visit root_path

    select 'Fire Nation', from: 'nation'

    click_button 'Search For Members'

    expect(current_path).to eq(search_path)
  end
  
end
