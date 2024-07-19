class AvatarService
  def self.conn 
    Faraday.new(url: 'https://last-airbender-api.fly.dev') do |faraday|
      faraday.headers['Content-Type'] = 'application/json'
    end
  end

  def self.get_characters(nation)
    response = conn.get("/api/v1/characters?affiliation=#{nation}&perPage=500&page=1")

    JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_first_25_characters(nation)
    response = conn.get("/api/v1/characters?affiliation=#{nation}&perPage=25&page=1")

    JSON.parse(response.body, symbolize_names: true)
  end
end