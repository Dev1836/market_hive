module HomesHelper
  def display_stock_data(stock_data, columns, show_checkboxes = false)
    stock_data.map do |item|
      content_tag(:tr) do
        columns.each do |column|
          concat content_tag(:td, item[column])
        end
        append_checkbox_td(item) if show_checkboxes
      end
    end.join.html_safe
  end

  def append_checkbox_td(item)
    concat content_tag(:td, check_box_tag('selected_stock_ids[]', item.id, current_user&.favorites&.include?(item), class: 'favorite-checkbox')) if current_user
  end

  def find_stock_by_symbol(stock_collection, symbol)
    stock_collection.find_by!(symbol: symbol)
  end

  def nifty_bank_stock(stock_nifty_bank)
    find_stock_by_symbol(stock_nifty_bank, "NIFTY BANK")
  end

  def nifty_50_stock(stock_nse)
    find_stock_by_symbol(stock_nse, "NIFTY 50")
  end

  def mcx_stock(stock_mcx)
    find_stock_by_symbol(stock_mcx, "MCX")
  end

  def stock_high_low_value(stock)
    stock.high_price - stock.low_price
  end
  
  def stock_high_low_percentage(stock)
    high_low_value = stock_high_low_value(stock)

    return 0 if high_low_value.zero?

    (((high_low_value) / stock.open_price.to_f) * 100).round(2).to_f
  end  
end
