module RkExchange
  module Adapters
    class Nse < Base

      MARKET_BASE_URL = "www.nseindia.com"
      MARKET_BASE_URI = "https://#{MARKET_BASE_URL}"
      MARKET_API_PATH = "/api"

      base_uri "#{MARKET_BASE_URI}#{MARKET_API_PATH}"

      def status
        api_request(:status)
      end

      def stock(index)
        api_request(:stock, query: { index: index })
      end

      def same_open_high(index)
        stock(index)
      end

      def same_open_low(index)
        stock(index)
      end

      def symbol_info(nse_symbol, expiry = nil)
        api_request(:symbol, query: { symbol: nse_symbol })
      end

      def losers
        api_request(:top_losers, query: { index: 'loosers' })
      end

      def gainers
        api_request(:top_gainers, query: { index: 'gainers' })
      end

      def most_active_by_value
        api_request(:most_active_by_value, query: { index: 'value' })
      end

      def most_active_by_volume
        api_request(:most_active_by_volume, query: { index: 'volume' })
      end

      private

      def headers
        super.merge({'Host' => MARKET_BASE_URL})
      end

      def endpoints
        {
          status: "/marketStatus",
          indices:"/allIndices",
          stock:  "/equity-stockIndices",
          symbol: "/quote-equity",
          top_losers:  "/live-analysis-variations",
          top_gainers: "/live-analysis-variations",
          most_active_by_value:  "/live-analysis-variations-most-active-securities",
          most_active_by_volume: "/live-analysis-variations-most-active-securities"
        }.freeze
      end

      def api_request(endpoint_key, options = {})
        get_api_request(endpoints[endpoint_key], options.merge(headers: headers))
      end
    end
  end
end
