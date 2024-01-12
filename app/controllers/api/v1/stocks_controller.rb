module Api
  module V1
    class StocksController < ApplicationController
      def create
        stock_data = params[:stocks]
        
        if stock_data.is_a?(Array)
          stock_data.each do |data|
            stock = Stock.find_by(symbol: data['symbol'])

            if stock.present?
              stock.update!(stock_params(data, data[:symbol]))
            else
              Stock.create!(stock_params(data, data[:symbol]))
            end
          end

          render json: { success: true, message: 'Stocks created or updated successfully' }
        else
          render json: { success: false, message: 'Invalid data format' }, status: :unprocessable_entity
        end
      end

      private

      def stock_params(data, name)
        {
          symbol: data["symbol"],
          index_name: data["index_name"],
          prev_price: data["prev_price"],
          high_price: data["high_price"],
          low_price: data["low_price"],
          open_price: data["open_price"],
          per_change: data["per_change"],
          last_price: data["last_price"],
          total_traded_volume: data["total_traded_volume"],
          total_traded_value: data["total_traded_value"]
        }
      end
    end
  end
end
