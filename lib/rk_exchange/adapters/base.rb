require "httparty"

module RkExchange
  module Adapters
    class Base
      include HTTParty
        
      def headers
        {
          'Accept' => 'application/json, text/javascript, */*; q=0.01',
          'Accept-Language' => 'en-US,en;q=0.5',
          'Accept-Encoding' => 'gzip, deflate, br',
          'Connection' => 'keep-alive',
          'Content-Length' => '0',
          'Content-Type' => 'application/json',
          'X-Requested-With' => 'XMLHttpRequest',
          'Sec-GPC' => '1',
          'DNT' => '1',
          'Upgrade-Insecure-Requests' => '1',
          'Pragma' => 'no-cache',
          'Cache-Control' => 'no-cache',
          'sec-ch-ua' => '"Chromium";v="118", "Brave";v="118", "Not=A?Brand";v="99"',
          'User-Agent' => 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:82.0) Gecko/20100101 Firefox/82.0'
        }
      end

      def get_api_request(endpoint, options = {})
        begin
          response = self.class.get(endpoint, options)
          JSON.parse(response.body)
        rescue StandardError => e
          raise "No Data Found: error: #{e}"
        end
      end

      def post_api_request(endpoint, options = {})
        begin
          response = self.class.post(endpoint, options)
          json_data = JSON.parse(response.body)['d']['Data']
        rescue StandardError => e
          raise "No Data Found: error: #{e}"
        end
        json_data
      end  

    end
  end
end      