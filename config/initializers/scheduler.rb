require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new

if Rails.env.development?
  scheduler.every '5m' do
    UpdateStocks.post_stock_data
    Rails.logger.info "Updated production stocks"
  end

  scheduler.every '5m' do
    NseDataProcessor.new.fetch_stock_data
    Rails.logger.info "Updated developement stocks"
  end  
end
