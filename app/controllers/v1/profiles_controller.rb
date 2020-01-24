class V1::ProfilesController < ApplicationController
  def index
    profiles = Profile.all
    render json: { data: ActiveModel::SerializableResource.new(profiles,  each_serializer: ProfileSerializer ).as_json, klass: 'Profile' }, status: :ok
  end

  def show
    @profile = Profile.find(params[:id])
    render json: { data: ProfileSerializer.new(@profile).as_json, klass: 'Profile' }, status: :ok
  end

  def create
    @profile = Profile.new(profile_params)
    if @profile.save
      render json: { data:  ProfileSerializer.new(@profile).as_json, klass: 'Profile' }, status: :ok
    end
  end

  def update
    @profile = Profile.find(params[:id])
    if @profile.update_attributes(profile_params)
      render json: { data: @profile, klass: 'Profile' }, status: :ok
    else
      render json: { data: @profile.errors.full_messages  }, status: :ok
    end
  end

  def profile_params
    params.require(:profile).permit!
  end

end
