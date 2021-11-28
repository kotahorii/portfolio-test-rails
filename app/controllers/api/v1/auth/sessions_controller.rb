class Api::V1::Auth::SessionsController < ApplicationController
  def index
    if current_api_v1_user
      render json: current_api_v1_user
    else
      render json: { message: "ユーザーが存在しません" }
    end
  end
end
