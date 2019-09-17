class V1::AuxiliaryTablesController < ApplicationController
  def index
    auxiliary_tables = AuxiliaryTable.all
    render json: { data: auxiliary_tables, model: 'AuxiliaryTable' }, status: :ok
  end

  def create
    auxiliary_table = AuxiliaryTable.new(auxiliary_table_params)
    if auxiliary_table.save!
      render json: { data: auxiliary_table, model: 'AuxiliaryTable' }, status: :ok
    else
      render json: { data: auxiliary_table.errors.full_messages  }, status: :ok
    end
  end

  def update
    @auxiliary_table = AuxiliaryTable.find(params[:id])
    if @auxiliary_table.update_attributes(auxiliary_table_params)
      render json: { data: @auxiliary_table, model: 'AuxiliaryTable' }, status: :ok
    else
      render json: { data: @auxiliary_table.errors.full_messages  }, status: :ok
    end
  end

  def show
    @auxiliary_table = AuxiliaryTable.find(params[:id])
    @auxiliary_table.data_format =   @auxiliary_table.content
    render json: { data: @auxiliary_table, model: 'AuxiliaryTable' }, status: :ok
  end

  private

  def auxiliary_table_params
    params.require(:auxiliary_table).permit!
  end
end
