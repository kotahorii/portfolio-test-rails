class Api::V1::PostsController < ApplicationController
  before_action :set_post, only: %i[show destroy]

  def index
    posts = Post.all.order(created_at: 'DESC')
    render json: posts
  end

  def show
    render json: @post
  end

  def create
    post = Post.new(post_params)
    post.user_id = current_api_v1_user.id
    if post.save
      render json: post
    else
      render json: { data: '投稿に失敗しました' }
    end
  end

  def destroy
    if @post.destroy
      render json: { data: '投稿を削除しました' }
    else
      render josn: { data: '削除に失敗しました' }
    end
  end

  def fav_sort
    posts = Post.includes(:fav_users).sort { |a, b| b.fav_users.size <=> a.fav_users.size }
    render json: posts
  end

  def rate_sort
    posts = Post.includes(:rate_users).sort { |a, b| b.rate_users.size <=> a.rate_users.size }
    render json: posts
  end

  def rate_ave
    array_size =-> (post) do
      post.rates.size == 0 ? 1 : post.rates.size
    end
    posts = Post.includes(:rates).sort { |a, b| b.rates.sum { |hash| hash[:rate] } / array_size.call(b) <=> a.rates.sum { |hash| hash[:rate] } / array_size.call(a) }
    render json: posts
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.permit(:title, :body, :prefecture, :city, :town, :image, :lat, :lng)
  end
end
