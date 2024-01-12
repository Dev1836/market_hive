class Mcx < Base
  def initialize
    @mcx_service = RkExchange::Client.mcx_client
  end

  def fetch_stock_data
    stock_data = @mcx_service.stock('MCX')
    current_month_data = stock_data.select do |stock|
      Date.parse(stock['ExpiryDate']).month == Date.today.month
    end

    if current_month_data.present?
      current_month_data.each do |data|
        stock = Stock.find_by(symbol: data['Symbol'])
        if stock.present?
          stock.update!(stock_params(data, 'MCX'))
        else
          Stock.create!(stock_params(data, 'MCX'))
        end
      end
    else
      puts "Failed to fetch stock data"
    end
  end

  def find_losers
    display_stock_data(order: :asc)
  end

  def find_gainers
    display_stock_data(order: :desc)
  end

  def same_open_high
    open_equals_high_data = Stock.where('open_price = high_price AND index_name = ?', 'MCX')
  end

  def same_open_low
    open_equals_low_data = Stock.where('open_price = low_price AND index_name = ?', 'MCX')
  end

  private

  def stock_params(data, stock_name)
    {
      index_name: stock_name,
      symbol: data['Symbol'],
      open_price: data['Open'],
      high_price: data['High'],
      low_price: data['Low'],
      last_price: data['LTP'],
      prev_price: data['PreviousClose'],
      per_change: data['PercentChange'],
      total_traded_volume: data['Volume'],
      total_traded_value: data['ValueInLacs'],
    }
  end

  def display_stock_data(order:)
    stock_data = Stock.where(index_name: 'MCX').order(per_change: order).limit(10)
  end
end
