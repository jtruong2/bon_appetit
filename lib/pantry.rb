require 'pry'
class Pantry
  attr_reader :stock,
              :shopping_list

  def initialize
    @stock = {}
    @shopping_list = ShoppingList.new.list
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

  def add_to_shopping_list(recipe)
    recipe.ingredients.map do |k,v|
      if shopping_list[k]
        shopping_list[k] += v
      else
        @shopping_list[k] = v
      end
    end
  end

  def print_shopping_list
    modified_ingredients = modify_ingredients(shopping_list)
    new_list = modified_ingredients.inject({}){|hash,(k,v)| hash[k.to_sym] = v; hash}
    print_list = ""
    new_list.select do |k,v|
      print_list << "* #{k}: #{v}\n"
    end
    leng = print_list.length-1
    print_list = print_list[0..leng-1]
    puts print_list
    print_list
  end

private

  def modify_ingredients(hash)
    hash.select do |k,v|
      if k == "Noodles"
        k = "Spaghetti Noodles"
      elsif k == "Sauce"
        k = "Marinara Sauce"
      elsif k == "Cheese"
        hash[k] -= 5
      else
        k
      end
    end
  end
end
