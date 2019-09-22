class V1::DocumentsController < ApplicationController
  def index
    documents = Document.all
    render json: { data: documents, klass: 'Document'  }, status: :ok
  end

  def create
    @document = Document.create(document_params)
    render json: { data: @document, klass: 'Document' }, status: :ok
  end

  def document_params
    params.require(:workflow).permit!
  end

end
