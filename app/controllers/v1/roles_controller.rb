class V1::RolesController < ApplicationController
  def index
    roles = Role.all
    render json: { data: ActiveModel::SerializableResource.new(roles,  each_serializer: RoleSerializer ).as_json, klass: 'Role' }, status: :ok
  end

  def show
    @role = Role.find(params[:id])
    render json: { data: RoleSerializer.new(@role).as_json, klass: 'Role' }, status: :ok
  end

  def create
    @role = Role.new(role_params)
    if @role.save
      render json: { data:  RoleSerializer.new(@role).as_json, klass: 'Role' }, status: :ok
    end
  end

  def update
    @role = Role.find(params[:id])
    if @role.update_attributes(role_params)
      render json: { data: @role, klass: 'Role' }, status: :ok
    else
      render json: { data: @role.errors.full_messages  }, status: :ok
    end
  end

  def role_params
    params.require(:role).permit!
  end

end
