class FightersController < ApplicationController
  def index
    render json: Fighter.order(:character)
  end

  def search
    name = params[:character].to_s.strip
    return render json: { error: "Please provide ?character=NAME" }, status: :bad_request if name.empty?

    fighter = Fighter.where("lower(character) = ?", name.downcase).first

    if fighter
      render json: fighter
    else
      render json: { error: "Fighter not found", query: name }, status: :not_found
    end
  end
end
