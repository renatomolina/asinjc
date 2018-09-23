class ProductParser
  def self.build_product(asin)
    begin
      page_content = open("https://www.amazon.com/dp/#{asin}").read

      Product.new(
        asin: asin,
        dimensions: dimension_parser(page_content),
        category: category_parser(page_content),
        rank: rank_parser(page_content)
      )
    rescue OpenURI::HTTPError
      return nil
    end
  end

  private

  def self.dimension_parser(page_content)
    page_content[/\d+((\d+|\.)\d+)?\sx\s\d+((\d+|\.)\d+)?\sx\s\d+((\d+|\.)\d+)?\sinches/] || 
      "Not found"
  end

  def self.category_parser(page_content)
    rank_category_parser_content = rank_category_parser(page_content)
    return 'Not found' if rank_category_parser_content.nil?
    rank_category_parser_content[/(?<= in ).*/]
  end

  def self.rank_parser(page_content)
    rank_category_parser_content = rank_category_parser(page_content)
    return 'Not found' if rank_category_parser_content.nil?
    rank_category_parser_content[/\d+(\,\d+)?/]
  end

  
  def self.rank_category_parser(page_content)
    # Matches the following format "#12,678 in Baby"
    page_content[/\#(\d+(\,\d+)?)\sin\s\w+[^(]*/]
  end
end