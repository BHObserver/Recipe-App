class RecipesController < ApplicationController


  def index
    @recipes = current_user.recipes.includes({ recipe_foods: :food }, :user).all
  end

  def show
    @recipe = Recipe.includes({ recipe_foods: :food }, :user).find(params[:id])
  end

  def public_recipes
    @public_recipes = Recipe.includes({ recipe_foods: :food }, :user).public_recipes
  end



  def new
    @recipe = current_user.recipes.new
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)


    if @recipe.save
      redirect_to @recipe, notice: 'Recipe was successfully created.'
    else
      render :new
    end
  end


  private

  def recipe_params
    params.require(:recipe).permit(:name, :photo, :preparation_time, :cooking_time, :description)
  end
end
