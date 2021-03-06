class Api::V1::UsersController < ApplicationController
  def create
    user = User.create(user_params)
    if user.save
      render json: UsersSerializer.new(user), status: 201
    else
      render json: payload(user), status: :unauthorized
      return
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end

  def payload(user)
    {
      error: user.errors.full_messages[0],
      status: 401
    }
  end
end
