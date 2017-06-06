require 'pry'
#* Centi-Units -- Equals 100 Universal Units
#* Milli-Units -- Equals 1/1000 Universal Units
class Pantry
  attr_reader :stock
  def initialize
    @stock = {}
  end

  def stock_check(item)
    if stock[item] == nil
      stock[item] = 0
    else
      stock[item]
    end
  end

  def restock(item, quantity)
    stock[item] += quantity
  end

  def convert_units(recipe)
    #1. If the recipe calls for more than
    #100 Units of an ingredient, convert it to Centi-units
    #2. If the recipe calls for less than 1 Units of an ingredient,
    #convert it to Milli-units
    converted_ingredients = {}
    recipe.ingredients.map do |k,v|
      if v > 100
         total = v/100
         converted_ingredients[k] = {quantity: total.to_i, units: "Centi-Units"}
      elsif v < 1
        total = v * 1000
        converted_ingredients[k] = {quantity: total.to_i, units: "Milli-Units"}
      else
        converted_ingredients[k] = {quantity: v, units: "Universal Units"}
      end
    end
    converted_ingredients
  end

end
