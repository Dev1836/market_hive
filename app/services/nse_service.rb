require 'httparty'

class NseService
  include HTTParty
  base_uri "https://www.nseindia.com"

  def base_uri
    ENV["BASE_URI"] || "https://www.nseindia.com"
  end

  def headers
    {
      'Host' => 'www.nseindia.com',
      'User-Agent' => 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:82.0) Gecko/20100101 Firefox/82.0',
      'Accept' => 'application/json, text/html;q=0.9',
      'Accept-Language' => 'en-US,en;q=0.5',
      'Accept-Encoding' => 'gzip, deflate, br',
      'DNT' => '1',
      'Connection' => 'keep-alive',
      'Upgrade-Insecure-Requests' => '1',
      'Pragma' => 'no-cache',
      'Cache-Control' => 'no-cache'
    }
  end

  def urls
  end

  def status
    market_status
  end
    
  def indexes
    all_indices
  end

  def symbol_info(equity_symbol)
    quote_equity(equity_symbol)
  end

  def stock(index='NIFTY 50')
    equity_stock_indices(index)
  end

  def losers
    variations('loosers')
  end

  def gainers
    variations('gainers')
  end

  def most_active

  end

  # private

  def all_indices
    self.class.get("/api/allIndices", headers: headers)
  end

  def market_status
    self.class.get("/api/marketStatus", headers: headers)
  end

  def price_band_hitter
    live_analysis('price-band-hitter')
  end

  def most_active_securities
    live_analysis('most-active-securities', 'value')
  end

  def variations(index)
    live_analysis('variations', index)
  end

  def live_analysis(url_postfix, index = nil)
    self.class.get("/api/live-analysis-#{url_postfix}", query: { index: index }, headers: headers)
  end

  def equity_stock_indices(index)
    self.class.get("/api/equity-stockIndices", query: { index: index }, headers: headers)
  end

  def quote_equity(equity_symbol)
    self.class.get("/api/quote-equity", query: { symbol: equity_symbol }, headers: headers)
  end
end
