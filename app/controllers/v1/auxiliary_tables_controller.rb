class V1::AuxiliaryTablesController < ApplicationController
  def index
    auxiliary_tables = AuxiliaryTable.all.order(:title)
    render json: { data: ActiveModel::SerializableResource.new(auxiliary_tables,  each_serializer: AuxiliaryTableSerializer ).as_json, klass: 'AuxiliaryTable' }, status: :ok
  end

  def multiple
    auxiliary_tables = AuxiliaryTable.where('id IN (?)', params[:ids].split(','))
    render json: { data: ActiveModel::SerializableResource.new(auxiliary_tables,  each_serializer: AuxiliaryTableSerializer ).as_json, klass: 'AuxiliaryTable' }, status: :ok
  end

  def show
    @auxiliary_table = AuxiliaryTable.find(params[:id])
    render json: { data:  AuxiliaryTableSerializer.new(@auxiliary_table).as_json, klass: 'AuxiliaryTable' }, status: :ok
  end

  def create
    auxiliary_table = AuxiliaryTable.new(auxiliary_table_params)
    if auxiliary_table.save!
      render json: { data: AuxiliaryTableSerializer.new(auxiliary_table).as_json, klass: 'AuxiliaryTable' }, status: :ok
    else
      render json: { data: auxiliary_table.errors.full_messages  }, status: :ok
    end
  end

  def update
    @auxiliary_table = AuxiliaryTable.find(params[:id])
    if @auxiliary_table.update_attributes(auxiliary_table_params)
      render json: { data: AuxiliaryTableSerializer.new(@auxiliary_table).as_json, klass: 'AuxiliaryTable' }, status: :ok
    else
      render json: { data: @auxiliary_table.errors.full_messages  }, status: :ok
    end
  end

  private

  def auxiliary_table_params
    params.require(:auxiliary_table).permit!
  end
end
