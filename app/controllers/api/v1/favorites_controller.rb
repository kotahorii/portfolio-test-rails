class Api::V1::FavoritesController < ApplicationController
  def index
    favorites = Favorite.all.order(created_at: 'DESC')
    render json: favorites
  end

  def create
    @favorite = current_api_v1_user.favorites.new(favorite_params)
    if @favorite.save
      render json: @favorite
    else
      render json: { data: '作成に失敗しました' }
    end
  end

  def destroy
    @favorite = current_api_v1_user.favorites.find_by(favorite_params)
    if @favorite.destroy
      render json: { data: '削除しました' }
    else
      render json: { data: '削除に失敗しました' }
    end
  end

  private

  def favorite_params
    params.permit(:post_id)
  end
end
