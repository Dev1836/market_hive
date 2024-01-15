module Api
  module V1  
    class FavoritesController < ApplicationController
      before_action :authenticate_user!, only: [:create,:destroy]

      def index
        @selected_stocks = current_user.favorites.includes(:stock).distinct.map do |favorite|
          stock = favorite.stock
        end
      end

      def create
        @favorite = Favorite.new(user_id: current_user.id, stock_id: params[:stock_id])

        if @favorite.save
          render json: { success: true, message: 'Stock added to favorites!' }
        else
          render json: { success: false, errors: @favorite.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        @favorite = Favorite.find_by(user_id: current_user.id, stock_id: params[:id])

        if @favorite
          @favorite.destroy
          render json: { success: true, message: 'Stock removed from favorites!' }
        else
          render json: { success: false, message: 'Favorite not found.' }, status: :not_found
        end
      end
    end
  end
end
