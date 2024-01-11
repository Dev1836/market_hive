# frozen_string_literal: true
require "rk_exchange/version"
require "rk_exchange/adapters/base"
require "rk_exchange/adapters/mcx"
require "rk_exchange/adapters/nse"

module RkExchange
  class Error < StandardError; end

  class Client    
    def initialize(adapter)
      @adapter = adapter.new
    end

    def self.nse_client
      new(Adapters::Nse)
    end

    def self.mcx_client
      new(Adapters::Mcx)
    end

    def same_open_high(index)
      @adapter.same_open_high(index)
    end

    def same_open_low(index)
      @adapter.same_open_low(index)
    end

    def stock
      @adapter.stock 
    end

    def symbol_info(market_symbol, expiry = nil)
      @adapter.symbol_info(market_symbol, expiry)
    end

    def losers
      @adapter.losers
    end

    def gainers
      @adapter.gainers
    end

    def most_active_by_value
      @adapter.most_active_by_value
    end

    def most_active_by_volume
      @adapter.most_active_by_volume
    end
  end
end
