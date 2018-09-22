class ProductParser
  def self.create(asin)
    page = Nokogiri::HTML(open("http://www.amazon.com/dp/#{asin}"))
    byebug
    product = Product.new(
      asin: asin,
      dimensions: parse_product_dimensions(page) || "Not found",
      category: parse_category(page) || "Not found",
      rank: parse_rank(page) || "Not found"
    )

    product
  end

  private

  def self.parse_product_dimensions(page)
    page.inner_html[/\d+((\d+|\.)\d+)?\sx\s\d+((\d+|\.)\d+)?\sx\s\d+((\d+|\.)\d+)?\sinches/]
  end

  def self.parse_category(page)
    rank_category_div_node = rank_category_div(page)
    return "Not found" if rank_category_div_node.nil?
    rank_category_div_node.split(' ').last
  end

  def self.parse_rank(page)
    rank_category_div_node = rank_category_div(page)
    return "Not found" if rank_category_div_node.nil?
    rank_category_div_node[/\d+(\,\d+)?/]
  end

  def self.rank_category_div(page)
    page.inner_html[/\d+\sin\s\w+[^(]*/]
  end
end