class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all

    respond_to do |format|
      format.json { render json: @recipes }
      format.html
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
  end
end
