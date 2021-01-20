class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      render json: UsersSerializer.new(user), status: 200
    elsif user && !user.authenticate(params[:password])
      render json: payload[:password_incorrect], status: 401
      return
    else
      render json: payload[:nonexistant_email], status: 401
      return
    end
  end

  private

  def payload
    {
      password_incorrect: {
        error: 'Password is incorrect',
        status: 401
      },
      nonexistant_email: {
        error: 'Email does not exist',
        status: 401
      }
    }
  end
end
