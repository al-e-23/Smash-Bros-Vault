require "json"

class SmashApiClient
  def initialize(base_url: "https://smashbrosapi.com/api/v1/ultimate")
    @conn = Faraday.new(base_url) do |f|
      f.response :json
      f.adapter  Faraday.default_adapter
    end
  end

  def characters
    get("/characters")
  end

  def stages
    get("/stages")
  end

  def moves(character_id:)
    get("/moves", { characterId: character_id })
  end

  private

  def get(path, params = {})
    res = @conn.get(path, params)
    raise "HTTP #{res.status}" unless res.success?
    nody = res.body

    if body.is_a?(String)
      JSON.parse(body)
    else
      body
  end
end
