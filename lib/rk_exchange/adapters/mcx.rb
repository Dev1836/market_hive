module RkExchange
  module Adapters

    class Mcx < Base

      MARKET_BASE_URL = "www.mcxindia.com"
      MARKET_BASE_URI = "https://#{MARKET_BASE_URL}"
      MARKET_API_PATH = "/backpage.aspx"
      
      base_uri "#{MARKET_BASE_URI}#{MARKET_API_PATH}"
      
      def status
        api_request(:status)
      end

      def indexes
        api_request(:indices)
      end

      def stock
        api_request(:stock)
      end

      def symbol_info(mcx_symbol, expiry)
        api_request(:symbol_info, query: { commodity: mcx_symbol, expiry: expiry, instrument_type: 'FUTCOM' })
      end

      def losers
        api_request(:top_losers)
      end

      def gainers
        api_request(:top_gainers)
      end

      def most_active_by_value
        api_request(:most_active_by_value, {InstrumentType: 'ALL'})
      end

      def most_active_by_volume
        api_request(:most_active_by_volume, {InstrumentType: 'ALL'})
      end

      private

      def headers
        super.merge({
          'Host' => MARKET_BASE_URL,
          'Origin' => MARKET_BASE_URI
        })
      end

      def endpoints
        {
          status: "",
          indices:"",
          stock:  "/GetMarketWatch",
          symbol: "/GetQuote", # GetQuote|GetQuoteOption|RecentQuote
          top_losers:  "/GetLosers",
          top_gainers: "/GetGainer", 
          most_active_by_value:  "/GetMostActiveContractByValueFilter", 
          most_active_by_volume: "/GetMostActiveContractByVolumeFilter"
        }
      end

      def referers
        {
          status: "",
          indices:"",
          stock:  "market-watch",
          symbol: "get-quote", 
          top_losers:  "top-losers",
          top_gainers: "top-gainers", 
          most_active_by_value:  "most-active-contracts", 
          most_active_by_volume: "most-active-contracts"
        }
      end

      def api_request(endpoint_key, payload={})
        referer = referers[endpoint_key]
        if endpoint_key == :symbol
          referer +=  "/#{payload[:instrument_type]}/#{payload[:commodity]}/#{payload[:expiry]}"
        end
        referer_header = headers.merge('Referer' => "#{MARKET_BASE_URI}/market-data/#{referer}")
        post_api_request(endpoints[endpoint_key], headers: referer_header, body: payload.to_json)
      end
    end
  end
end
