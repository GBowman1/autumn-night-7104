class AvatarService
  def self.conn 
    Faraday.new(url: 'https://last-airbender-api.fly.dev') do |faraday|
      faraday.headers['Content-Type'] = 'application/json'
    end
  end

  
end