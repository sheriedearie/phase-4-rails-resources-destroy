class BirdsController < ApplicationController

  # GET /birds
  def index
    birds = Bird.all
    render json: birds
  end

  # POST /birds
  def create
    bird = Bird.create(bird_params)
    render json: bird, status: :created
  end

  # GET /birds/:id
  def show
    bird = Bird.find_by(id: params[:id])
    if bird
      render json: bird
    else
      render json: { error: "Bird not found" }, status: :not_found
    end
  end

  # PATCH /birds/:id
  def update
    bird = Bird.find_by(id: params[:id])
    if bird
      bird.update(bird_params)
      render json: bird
    else
      render json: { error: "Bird not found" }, status: :not_found
    end
  end

  # PATCH /birds/:id/like
  def increment_likes
    bird = Bird.find_by(id: params[:id])
    if bird
      bird.update(likes: bird.likes + 1)
      render json: bird
    else
      render json: { error: "Bird not found" }, status: :not_found
    end
  end

  def destory
    bird = Bird.find_by(id: params[:id])
    # find the bird using the ID from the route params
    if bird
      bird.destory
      # remove it from the database with bird.destory
      head :no_content
      # did this instead of a render json resp. 
      # if bird was deleted it will give a 204 status code indicating the server
      # was successful
    else
      render json: { error: "Bird not found" }, status: :not_found
    end
  end

  private

  def bird_params
    params.permit(:name, :species, :likes)
  end

end
