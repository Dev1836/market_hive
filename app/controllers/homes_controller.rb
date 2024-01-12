class HomesController < ApplicationController
  def index
    nse_data
    mcx_data
    nifty_bank_data
  end

  private

  def nse_data
    nse = Nse.new
    @gainers_nse = nse.find_gainers_nifty_50
    @losers_nse = nse.find_losers_nifty_50
    @same_open_low_nse = nse.same_open_low_nifty_50
    @same_open_high_nse = nse.same_open_high_nifty_50
    @stock_nse = nse.all_stock_data_nifty_50
  end

  def nifty_bank_data
    nifty_bank = Nse.new
    @gainers_nifty_bank = nifty_bank.find_gainers_nifty_bank
    @losers_nifty_bank = nifty_bank.find_losers_nifty_bank
    @same_open_low_nifty_bank = nifty_bank.same_open_low_nifty_bank
    @same_open_high_nifty_bank = nifty_bank.same_open_high_nifty_bank
    @stock_nifty_bank = nifty_bank.all_stock_data_nifty_bank
  end

  def mcx_data
    mcx = Mcx.new
    @gainers_mcx = mcx.find_gainers
    @losers_mcx = mcx.find_losers
    @same_open_low_mcx = mcx.same_open_low
    @same_open_high_mcx = mcx.same_open_high
    @stock_mcx = mcx.all_stock_data
  end
end
