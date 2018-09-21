class ProductParser
  def self.create(asin)
    byebug
    result = Faraday.get "www.amazon.com/dp/#{asin}" 
  end
end