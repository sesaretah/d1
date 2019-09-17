class V1::DocumentsController < ApplicationController
  def index
    documents = Document.all
    render json: { data: documents }, status: :ok
  end
end
