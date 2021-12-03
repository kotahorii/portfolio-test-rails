class Api::V1::LabelsController < ApplicationController
  before_action :set_label, except: %i[index create]

  def index
    labels = Label.all
    render json: labels
  end

  def create
    label = Label.new(label_params)
    label.user_id = current_api_v1_user.id
    if label.save
      render json: label
    else
      render json: { data: '作成に失敗しました'}
    end
  end

  def destroy
    if @label.destroy
      render json: { data: '投稿を削除しました' }
    else
      render json: { data: '削除に失敗しました' }
    end
  end

  private

  def set_label
    @label = Label.find(params[:id])
  end

  def label_params
    params.permit(:name, :post_id)
  end
end
