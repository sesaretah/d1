class V1::UsersController < ApplicationController
  include JWTWrapper

  def index
    users = User.all
    render json: { data: ActiveModel::SerializableResource.new(users,  each_serializer: UserSerializer ).as_json, klass: 'User' }, status: :ok
  end

  def login
    if User.find_by_email(params['email']).try(:valid_password?, params[:password])
      @user = User.find_by_email(params['email'])
      render :json => { klass: 'User', data: {result: 'OK',token: JWTWrapper.encode({ user_id: @user.id }), user_id: @user.id}}.to_json , :callback => params['callback']
    else
      render :json => {result: 'ERROR',  error: I18n.t(:doesnt_match) }.to_json , status: :unprocessable_entity
    end
  end


  def sign_up
    @user = User.new(email: params['email'], password: params['password'], password_confirmation: params['password_confirmation'])
    if @user.save
      render :json => { klass: 'User', data: {result: 'OK',  token: JWTWrapper.encode({ user_id: @user.id }), user_id: @user.id}}.to_json, :callback => params['callback']
    else
      render :json => {result: 'ERROR', error: @user.errors }.to_json , status: :unprocessable_entity
    end
  end

end
