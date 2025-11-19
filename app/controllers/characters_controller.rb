class CharactersController < ApplicationController
  def index
    client = SmashApiClient.new
    @characters = client.characters
  end

  def show
    client      = SmashApiClient.new
    all_chars   = client.characters

    @character = all_chars.find do |c|
      c["id"].to_s == params[:id] || c["name"].parameterize == params[:id]
    end

    @moves = []
  end
end
