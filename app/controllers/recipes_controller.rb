class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all

    respond_to do |format|
      format.html

      format.json do
        render json: @recipes,
               adapter: :json,
               each_serializer: SimpleRecipeSerializer
      end
    end
  end

  def show
    @recipe = Recipe
      .includes(recipe_versions: { ingredients: %i[product unit] })
      .find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @recipe }
    end
  end
end
