require 'test_helper'
class ApplicationHelperTest < ActionView::TestCase

  context "text#textile_to_html" do
    setup do
      @textile = "h2. Hello World"
    end

    should "convert textile to html" do
      assert_equal textile_to_html(@textile), "<h2>Hello World</h2>"
    end
    should "return empty string for blank text" do
      assert_equal textile_to_html(nil), ""
    end
  end

end