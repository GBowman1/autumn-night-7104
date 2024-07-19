class AvatarService
  def self.conn 
    Faraday.new(url: 'https://last-airbender-api.fly.dev') do |faraday|
      faraday.headers['Content-Type'] = 'application/json'
    end
  end

  def self.get_characters(nation)
    response = conn.get("/api/v1/characters?affiliation=#{nation}")
    
    JSON.parse(response.body, symbolize_names: true)
  end
end