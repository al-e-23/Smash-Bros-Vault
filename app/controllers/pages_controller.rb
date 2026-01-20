class PagesController < ApplicationController
  def fighter_search
    @query = params[:character]

    selected_id = params[:id].presence # stores the character that is selected 

    @fighters = [] # This returns an array of fighters that match with the input
    @fighter = nil  # This returns a single fighter that exactly matches the input

    if @query.present?
      @fighters = Fighter.where("character LIKE ?", "%#{@query}%").order(:character) # List of matches from my csv data
    end

    if selected_id
      @fighter = Fighter.find_by(id: selected_id) # Selects the character by ID 
      @query = @fighter.character if @fighter # Updates the query to the selected character name
    end

    if @fighter.nil? && @fighters.size == 1   # Automatically selects the fighter if there is only one match
      @fighter = @fighters.first
    end

    if @fighter
      client = SmashwikiClient.new
      @wiki_title = client.search_title("#{@fighter.character} (SSBU)") # Searches for the character on Smashwiki with "(SSBU)" otherwise, it wouldn't know who you were searching
      @wiki_image_url = client.image_url_for(@wiki_title) if @wiki_title.present?   # Returns the image url for the character
    end
  end
end
