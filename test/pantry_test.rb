require_relative 'test_helper'

class PantryTest < Minitest::Test

  def test_it_exists
    pantry = Pantry.new

    assert_instance_of Pantry, pantry
  end

  def test_check_stock
    pantry = Pantry.new

    assert_equal 0, pantry.stock_check("Cheese")
  end

  def test_checking_and_adding_stock
    pantry = Pantry.new

    assert_equal ({}), pantry.stock
    assert_equal 0 , pantry.stock_check("Cheese")

    pantry.restock("Cheese", 10)
    assert_equal 10, pantry.stock_check("Cheese")

    pantry.restock("Cheese", 20)
    assert_equal 30, pantry.stock_check("Cheese")

  end

  def test_convert_units
    r = Recipe.new("Spicy Cheese Pizza")
    pantry = Pantry.new

    r.add_ingredient("Cayenne Pepper", 0.025)
    r.add_ingredient("Cheese", 75)
    r.add_ingredient("Flour", 500)

    expected = ({"Cayenne Pepper" => {quantity: 25, units: "Milli-Units"},
    "Cheese"=>{quantity: 75, units: "Universal Units"},
    "Flour"=> {quantity: 5, units: "Centi-Units"}})

    assert_equal expected, pantry.convert_units(r)

  end

  def test_add_to_shopping_list
    pantry = Pantry.new
    r = Recipe.new("Cheese Pizza")
    puts r.ingredients
    r.add_ingredient("Cheese", 20)
    r.add_ingredient("Flour", 20)
    puts r.ingredients
    pantry.add_to_shopping_list(r)
    expected = {"Cheese" => 20, "Flour" => 20}

    assert_equal expected, pantry.shopping_list
  end

  def test_add_another_recipe_and_print_list
    pantry =Pantry.new

    r = Recipe.new("Cheese Pizza")
    puts r.ingredients
    r.add_ingredient("Cheese", 20)
    r.add_ingredient("Flour", 20)
    puts r.ingredients
    pantry.add_to_shopping_list(r)

    r = Recipe.new("Spaghetti")
    r.add_ingredient("Noodles", 10)
    r.add_ingredient("Sauce", 10)
    r.add_ingredient("Cheese", 5)
    pantry.add_to_shopping_list(r)
    expected = {"Cheese" => 25, "Flour" => 20, "Noodles" => 10, "Sauce" => 10}

    assert_equal expected, pantry.shopping_list

    expected = "* Cheese: 20\n* Flour: 20\n* Spaghetti Noodles: 10\n* Marinara Sauce: 10"
    assert_equal expected, pantry.print_shopping_list
  end


end
