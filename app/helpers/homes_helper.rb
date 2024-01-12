module HomesHelper
  def display_stock_data(stock_data, columns, show_checkboxes = false)
    stock_data.map do |item|
      content_tag(:tr) do
        columns.each do |column|
          concat content_tag(:td, item[column])
        end
        if show_checkboxes
          concat content_tag(:td, check_box_tag('selected_stock_ids[]', item.id, current_user&.favorites&.include?(item), class: 'favorite-checkbox')) if current_user
        end
      end
    end.join.html_safe
  end

  def display_gainers_data(gainers_nse)
    columns = ['symbol', 'open_price', 'high_price', 'low_price', 'last_price', 'prev_price', 'per_change']
    display_stock_data(gainers_nse, columns)
  end

  def nifty_50
    Stock.find_by(symbol: "NIFTY 50")
  end

  def display_losers_data(losers_data)
    columns = ['symbol', 'open_price', 'high_price', 'low_price', 'last_price', 'prev_price', 'per_change']
    display_stock_data(losers_data, columns)
  end

  def display_same_open_low(data)
    columns = ['symbol', 'open_price', 'high_price', 'low_price', 'last_price', 'prev_price', 'per_change']
    display_stock_data(data, columns)
  end

  def display_same_open_high(data)
    columns = ['symbol', 'open_price', 'high_price', 'low_price', 'last_price', 'prev_price', 'per_change']
    display_stock_data(data, columns)
  end

  def display_all_stock_data(data)
    columns = ['symbol', 'open_price', 'high_price', 'low_price', 'last_price', 'prev_price', 'per_change','total_traded_volume', 'total_traded_value']
    display_stock_data(data, columns)
  end
end
