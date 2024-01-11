class HomesController < ApplicationController
  def index
    nse_data_processor = NseDataProcessor.new
    @gainers_data = nse_data_processor.find_gainers
    @losers_data = nse_data_processor.find_losers
    @same_open_low_data = nse_data_processor.same_open_low
    @same_open_high_data = nse_data_processor.same_open_high
    @stock_data = nse_data_processor.all_stock_data
  end
end
