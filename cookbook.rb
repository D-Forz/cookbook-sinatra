require 'csv'
require_relative 'recipe'

class Cookbook
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @recipes = []
    load_data
  end

  def all
    @recipes
  end

  def find(index)
    @recipes[index]
  end

  def add_recipe(recipe)
    @recipes << recipe
    save_data
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    save_data
  end

  def load_data
    CSV.foreach(@csv_file_path) do |row|
      row[4] = row[4] == 'true'
      recipe = Recipe.new(name: row[0], description: row[1], rating: row[2], prep_time: row[3], done: row[4])
      @recipes << recipe
    end
  end

  def save_data
    CSV.open(@csv_file_path, 'wb') do |csv|
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.rating, recipe.prep_time, recipe.done?]
      end
    end
  end

  def destroy_all
    @recipes = []
    save_data
  end
end
