class Nse < Base
  def initialize
    @nse_service = RkExchange::Client.nse_client
  end

  def fetch_stock_data(index)
    stock_data = @nse_service.stock(index)
    
    if stock_data
      stock_data['data'].each do |data|
        stock = Stock.find_by(symbol: data['symbol'])
        
        if stock.present?
          stock.update!(stock_params(data, stock_data['name']))
        else
          Stock.create!(stock_params(data, stock_data['name']))
        end
      end
    else
      puts "Failed to fetch stock data for #{index}"
    end
  end

  def find_losers_nifty_50
    display_stock_data('NIFTY 50', order: :asc)
  end

  def all_stock_data_nifty_50
    Stock.where('index_name = ?', 'NIFTY 50')
  end

  def find_gainers_nifty_50
    display_stock_data('NIFTY 50', order: :desc)
  end

  def same_open_high_nifty_50
    Stock.where('open_price = high_price AND index_name = ?', 'NIFTY 50')
  end

  def same_open_low_nifty_50
    Stock.where('open_price = low_price AND index_name = ?', 'NIFTY 50')
  end

  def find_losers_nifty_bank
    display_stock_data('NIFTY BANK', order: :asc)
  end

  def all_stock_data_nifty_bank
    Stock.where('index_name = ?', 'NIFTY BANK')
  end

  def find_gainers_nifty_bank
    display_stock_data('NIFTY BANK', order: :desc)
  end

  def same_open_high_nifty_bank
    Stock.where('open_price = high_price AND index_name = ?', 'NIFTY BANK')
  end

  def same_open_low_nifty_bank
    Stock.where('open_price = low_price AND index_name = ?', 'NIFTY BANK')
  end

  private

  def stock_params(data, stock_name)
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

  def display_stock_data(index, order:)
    Stock.where(index_name: index).order(per_change: order).limit(10)
  end
end
