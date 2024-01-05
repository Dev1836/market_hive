class HomeController < ApplicationController
  def index
    fetch_nse_data
    fetch_mcx_data
  end

  private

  def fetch_nse_data
    nse_client = RkExchange::Client.nse_client
    @gainers_data = nse_client.gainers
    @losers_data = nse_client.losers
    @stock_data = nse_client.stock("NIFTY 50")
  end

  def fetch_mcx_data
    mcx_client = RkExchange::Client.mcx_client
    @mcx_losers = mcx_client.losers
  end
end
