class WelcomeController < ApplicationController
  def index
  end

  def participants
    render json: { results: Participants::Process.new(params[:url]).to_a }, status: :ok
  end
end
