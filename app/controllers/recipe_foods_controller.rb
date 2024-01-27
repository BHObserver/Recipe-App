class RecipeFoodsController < ApplicationController
  before_action :authenticate_user!

  def new
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = @recipe.recipe_foods.new
    @foods = Food.all
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = @recipe.recipe_foods.new(recipe_food_params)
    authorize! :update, @recipe

    if food_already_added?(@recipe_food.food, @recipe)
      flash[:alert] = 'This food has already been added to the recipe'
      @foods = Food.all
      render :new
    elsif @recipe_food.save
      flash[:notice] = "#{@recipe_food.food.name} ingredient was successfully added to the recipe"
      redirect_to recipe_path(@recipe)
    else
      flash[:alert] = 'The food could not be added to the recipe, please check the form and try again'
      @foods = Food.all
      render :new
    end
  end

  def edit
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = @recipe.recipe_foods.find(params[:id])
    @foods = Food.all
  end

  def update
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = @recipe.recipe_foods.find(params[:id])
    authorize! :update, @recipe

    if @recipe_food.update(recipe_food_params)
      flash[:notice] = 'The ingredient was successfully updated'
      redirect_to recipe_path(@recipe_food.recipe)
    else
      flash[:alert] = 'The ingredient could not be updated, please check the form and try again'
      @foods = Food.all
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = @recipe.recipe_foods.find(params[:id])
    authorize! :update, @recipe

    @recipe_food.destroy
    flash[:notice] = 'The ingredient was successfully removed from the recipe'
    redirect_to recipe_path(@recipe), status: :see_other
  end

  def generate_shopping_list
    user_recipes = Recipe.includes(recipe_foods: :food).where(user_id: current_user.id)
    user_foods = extract_user_foods(user_recipes)
    consolidated_food_list = consolidate_food_list(user_foods)

    general_foods = Food.where(user_id: current_user.id).pluck(:id, :quantity)
    missing_food_items = find_missing_food_items(consolidated_food_list, general_foods)

    total_count = calculate_total_count(missing_food_items)
    total_price = calculate_total_price(missing_food_items)

    @shopping_items = {
      missing_food_items:,
      total_count:,
      total_price:
    }
  end

  private

  def extract_user_foods(user_recipes)
    user_recipes.map { |recipe| recipe.recipe_foods.map(&:food) }.flatten
  end

  def consolidate_food_list(user_foods)
    user_foods.group_by(&:id).transform_values { |foods| foods.sum(&:quantity) }
  end

  def find_missing_food_items(consolidated_food_list, general_foods)
    consolidated_food_list.reject do |food_id, quantity|
      general_foods_hash = general_foods.to_h
      general_foods_hash[food_id] && general_foods_hash[food_id] >= quantity
    end
  end

  def calculate_total_count(missing_food_items)
    missing_food_items.values.sum
  end

  def calculate_total_price(missing_food_items)
    missing_food_items.sum { |food_id, quantity| Food.find(food_id).price * quantity }
  end

  def food_already_added?(food, recipe)
    return true if food.nil?

    RecipeFood.find_by(food_id: food.id, recipe_id: recipe.id)
  end

  def recipe_food_params
    params.require(:recipe_food).permit(:food_id, :quantity)
  end
end
