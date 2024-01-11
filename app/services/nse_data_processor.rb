require_relative 'nse_service'

class NseDataProcessor
  def initialize
    @nse_service = NseService.new
  end

  def fetch_stock_data
    stock_data = @nse_service.stock(index='NIFTY 50')
    if stock_data.success?
      stock_data['data'].each do |data|
        stock = Stock.find_by(symbol: data['symbol'])
        if stock.present?
          stock.update!(create_or_update_stock(data, stock_data['name']))
        else
          Stock.create!(create_or_update_stock(data,stock_data['name']))
        end
      end
    else
      puts "Failed to fetch stock data"
    end
  end

  def find_losers
    display_stock_data(order: :asc)
  end

  def all_stock_data
    stock = Stock.all
  end

  def find_gainers
    display_stock_data(order: :desc)
  end

  def same_open_high
    open_equals_high_data = Stock.where('open_price = high_price')
  end

  def same_open_low
    open_equals_low_data = Stock.where('open_price = low_price')
  end

  private

  def create_or_update_stock(data, stock_name)
    {
      index_name: stock_name,
      symbol: data['symbol'],
      open_price: data['open'],
      high_price: data['dayHigh'],
      low_price: data['dayLow'],
      last_price: data['lastPrice'],
      prev_price: data['previousClose'],
      per_change: data['pChange'],
      total_traded_volume: data['totalTradedVolume'],
      total_traded_value: data['totalTradedValue'],
    }
  end

  def display_stock_data(order:)
    stock_data = Stock.order(per_change: order).limit(10)
  end
end
