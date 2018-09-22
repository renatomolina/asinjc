class ProductParser
  def self.build_product(asin)
    begin
      page = Nokogiri::HTML(open("http://www.amazon.com/dp/#{asin}"))

      product = Product.new(
        asin: asin,
        dimensions: parse_product_dimensions(page),
        category: parse_category(page),
        rank: parse_rank(page) || "Not found"
      )

      product
    rescue
      return nil
    end
  end

  private

  def self.parse_product_dimensions(page)
    page.inner_html[/\d+((\d+|\.)\d+)?\sx\s\d+((\d+|\.)\d+)?\sx\s\d+((\d+|\.)\d+)?\sinches/] || 
      "Not found"
  end

  def self.parse_category(page)
    rank_category_element_text = rank_category_element(page)
    rank_category_element_text.split(' ').last || "Not found"
  end

  def self.parse_rank(page)
    rank_category_element_text = rank_category_element(page)
    rank_category_element_text[/\d+(\,\d+)?/] || "Not found"
  end

  def self.rank_category_element(page)
    page.inner_html[/(\d+(\,\d+)?)\sin\s\w+[^(]*/]
  end
end