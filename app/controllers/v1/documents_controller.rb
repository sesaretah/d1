class V1::DocumentsController < ApplicationController
  def index
    documents = Document.all
    render json: { data: ActiveModel::SerializableResource.new(documents,  each_serializer: DocumentSerializer ).as_json, klass: 'Document' }, status: :ok
  end

  def show
    @document = Document.find(params[:id])
    render json: { data: DocumentSerializer.new(@document).as_json, klass: 'Document' }, status: :ok
  end

  def create
    @document = Document.new(document_params)
    if @document.save
      AuxiliaryRecord.batch_save(params[:auxiliary_records], @document.id)
    end
    render json: { data: DocumentSerializer.new(@document).as_json, klass: 'Document' }, status: :ok
  end

  def update
    @document = Document.find(params[:id])
    if @document.update_attributes(document_params)
      AuxiliaryRecord.batch_save(params[:auxiliary_records], @document.id)
      render json: { data: DocumentSerializer.new(@document).as_json, klass: 'Document' }, status: :ok
    else
      render json: { data: @document.errors.full_messages  }, status: :ok
    end
  end

  def document_params
    params.require(:document).permit!
  end

end
