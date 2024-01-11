require 'httparty'

class UpdateStocks
  include HTTParty

  API_URL = 'https://rails-ez8l.onrender.com/api/v1/stocks'.freeze

  def self.post_stock_data
    stocks = Stock.all.map(&:attributes).to_json
    stocks = JSON.parse(stocks)
    
    response = HTTParty.post(
      API_URL,
      body: { stocks: stocks }.to_json,
      headers: { 'Content-Type' => 'application/json' }
    )

    Rails.logger.info "Updated stocks data from local"
  end
end