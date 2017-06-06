require_relative 'test_helper'
class ShoppingListTest < Minitest::Test
  def test_it_exists
    sl = ShoppingList.new

    assert_instance_of ShoppingList, sl
  end

  def test_list_is_empty_by_default
    sl = ShoppingList.new

    assert_equal ({}) , sl.list
  end
end
