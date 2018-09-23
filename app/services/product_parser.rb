class ProductParser
  def self.build_product(asin)
    begin
      page = Nokogiri::HTML(open("https://www.amazon.com/dp/#{asin}"))

      product = Product.new(
        asin: asin,
        dimensions: parse_product_dimensions(page),
        category: parse_category(page),
        rank: parse_rank(page)
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
    return 'Not found' if rank_category_element_text.nil?
    rank_category_element_text[/(?<= in ).*/]
  end

  def self.parse_rank(page)
    rank_category_element_text = rank_category_element(page)
    return 'Not found' if rank_category_element_text.nil?
    rank_category_element_text[/\d+(\,\d+)?/]
  end

  def self.rank_category_element(page)
    page.inner_html[/\#(\d+(\,\d+)?)\sin\s\w+[^(]*/]
  end
end