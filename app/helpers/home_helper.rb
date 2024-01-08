module HomeHelper
  def display_stock_data(stock_data, columns)
    stock_data['NIFTY']['data'].map do |item|
      content_tag(:tr) do
        columns.each do |column|
          concat content_tag(:td, item[column])
        end
      end
    end.join.html_safe
  end

  def display_gainers_data(gainers_data)
    return if gainers_data.empty?

    columns = ['symbol', 'ltp', 'prev_price', 'high_price', 'low_price', 'open_price', 'net_price', 'perChange', 'market_type']
    display_stock_data(@gainers_data, columns)
  end

  def display_losers_data(losers_data)
    return if losers_data.empty?

    columns = ['symbol', 'series', 'open_price', 'high_price', 'low_price', 'ltp', 'prev_price', 'net_price', 'trade_quantity']
    display_stock_data(@losers_data, columns)
  end

  def same_open_low(data)
    return if data.empty?
    
    filtered_data = data['data'].select { |item| item['open'] == item['dayLow'] }
    columns = ['symbol', 'open', 'dayHigh', 'dayLow', 'lastPrice', 'previousClose', 'change', 'pChange', 'ffmc']
    display_stock_data({ 'NIFTY' => { 'data' => filtered_data } }, columns)
  end

  def same_open_high(data)
    return if data.empty?

    filtered_data = data['data'].select { |item| item['open'] == item['dayHigh'] }
    columns = ['symbol', 'open', 'dayHigh', 'dayLow', 'lastPrice', 'previousClose', 'change', 'pChange', 'ffmc']
    display_stock_data({ 'NIFTY' => { 'data' => filtered_data } }, columns)
  end

  def mcx_data(data)
    return if data.empty?

    columns = ['AbsoluteChange', 'EngSymbol', 'ExpiryDate', 'LTP', 'LTT', 'PercentChange', 'PreviousClosed', 'Symbol']
    data.map do |item|
      content_tag(:tr) do
        columns.each do |column|
          concat content_tag(:td, item[column])
        end
      end
    end.join.html_safe
  end
end
