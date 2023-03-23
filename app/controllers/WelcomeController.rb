class WelcomeController < ApplicationController
  def index
    render json: { message: 'Welcome to the superb Beer Selfservice API' }
  end
end
