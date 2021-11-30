class Api::V1::PostsController < ApplicationController
  before_action :set_post, except: %i[index create]

  def index
    posts = Post.all.order(created_at: 'DESC')
    render json: posts
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

  def update
    @post.title = post_params[:title]
    @post.body = post_params[:body]
    @post.prefecture = post_params[:prefecture]
    @post.city = post_params[:city]
    @post.town = post_params[:town]
    @post.genre = post_params[:genre]
    @post.image = post_params[:image] if post_params[:image] != ''
    @post.user_id = current_api_v1_user.id

    if @post.save
      render json: @post
    else
      render json: { data: '更新に失敗しました' }
    end
  end

  def destroy
    if @post.destroy
      render json: { data: '投稿を削除しました' }
    else
      render josn: { data: '削除に失敗しました' }
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.permit(:title, :body, :prefecture, :city, :town, :genre, :image)
  end
end
