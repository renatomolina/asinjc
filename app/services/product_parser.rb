class ProductParser
  def self.build_product(asin)
    begin
      page_content = open("https://www.amazon.com/dp/#{asin}").read

      product = Product.new(
        asin: asin,
        dimensions: parse_product_dimensions(page_content),
        category: parse_category(page_content),
        rank: parse_rank(page_content)
      )

      product
    rescue
      return nil
    end
  end

  private

  def self.parse_product_dimensions(page_content)
    page_content[/\d+((\d+|\.)\d+)?\sx\s\d+((\d+|\.)\d+)?\sx\s\d+((\d+|\.)\d+)?\sinches/] || 
      "Not found"
  end

  def self.parse_category(page_content)
    rank_category_element_text = rank_category_element(page_content)
    return 'Not found' if rank_category_element_text.nil?
    rank_category_element_text[/(?<= in ).*/]
  end

  def self.parse_rank(page_content)
    rank_category_element_text = rank_category_element(page_content)
    return 'Not found' if rank_category_element_text.nil?
    rank_category_element_text[/\d+(\,\d+)?/]
  end

  def self.rank_category_element(page_content)
    page_content[/\#(\d+(\,\d+)?)\sin\s\w+[^(]*/]
  end
end