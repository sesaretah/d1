class V1::AuxiliaryRecordsController < ApplicationController
  def index
    auxiliary_records = AuxiliaryRecord.where(auxiliary_table_id: params[:auxiliary_table_id])
    render json: { data: AuxiliaryRecord.with_content(auxiliary_records) }, status: :ok
  end

  def create
    auxiliary_record = AuxiliaryRecord.new(auxiliary_record_params)
    if auxiliary_record.save!
      render json: { data: auxiliary_record, model: 'AuxiliaryRecord'}, status: :ok
    else
      render json: { data: auxiliary_record.errors.full_messages  }, status: :ok
    end
  end

  def show
    @auxiliary_record = AuxiliaryRecord.find(params[:id])
    @auxiliary_record.content
    render json: { data: @auxiliary_record, model: 'AuxiliaryRecord' }, status: :ok
  end

  def delete
    @auxiliary_record = AuxiliaryRecord.find_by_uuid(params[:uuid])
    if @auxiliary_record
      @auxiliary_record.destroy
      render json: { data: @auxiliary_record, model: 'AuxiliaryRecord' }, status: :ok
    end
  end

  private

  def auxiliary_record_params
    params.require(:auxiliary_record).permit!
  end
end
