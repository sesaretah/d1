class V1::DocumentsController < ApplicationController
  def index
    documents = Document.all
    render json: { data: Document.records(documents), klass: 'Document'  }, status: :ok
  end

  def show
    @document = Document.find(params[:id])
    render json: { data: @document.record, klass: 'Document' }, status: :ok
  end

  def create
    @document = Document.new(document_params)
    if @document.save
      AuxiliaryRecord.batch_build(params[:auxiliary_records], @document.id)
    end
    render json: { data: @document.record, klass: 'Document' }, status: :ok
  end

  def update
    @document = Document.find(params[:id])
    if @document.update_attributes(document_params)
      render json: { data: @document, klass: 'Document' }, status: :ok
    else
      render json: { data: @document.errors.full_messages  }, status: :ok
    end
  end

  def document_params
    params.require(:document).permit!
  end

end
