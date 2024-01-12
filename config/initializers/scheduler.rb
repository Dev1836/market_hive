require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new

if Rails.env.development?
  scheduler.every '5m' do
    UpdateStocks.post_stock_data
    Rails.logger.info "Updated production stocks"
  end

  scheduler.every '5m' do
    Nse.new.fetch_stock_data('NIFTY 50')
    Nse.new.fetch_stock_data('NIFTY BANK')
    Mcx.new.fetch_stock_data
    Rails.logger.info "Updated developement stocks"
  end  
end
