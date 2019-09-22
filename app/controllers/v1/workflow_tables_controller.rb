class V1::WorkflowTablesController < ApplicationController
  def index
    if params[:workflow_id].blank?
      render json: { data: WorkflowTable.grouped, klass: 'WorkflowTable' }, status: :ok
    else
      @workflow_tables = WorkflowTable.where(workflow_id: params[:workflow_id])
      render json: { data: @workflow_tables, klass: 'WorkflowTable' }, status: :ok
    end
  end

  def create
    workflow_table = WorkflowTable.new(workflow_table_params)
    if workflow_table.save!
      render json: { data: workflow_table, klass: 'WorkflowTable' }, status: :ok
    else
      render json: { data: workflow_table.errors.full_messages  }, status: :ok
    end
  end

  def update
    @workflow_table = WorkflowTable.find(params[:id])
    if @workflow_table.update_attributes(workflow_table_params)
      render json: { data: @workflow_table, klass: 'WorkflowTable' }, status: :ok
    else
      render json: { data: @workflow_table.errors.full_messages  }, status: :ok
    end
  end

  def show
    @workflow_table = WorkflowTable.find(params[:id])
    render json: { data: @workflow_table, klass: 'WorkflowTable' }, status: :ok
  end

  def delete
    @workflow_table = WorkflowTable.where(workflow_id: params[:workflow_id], auxiliary_table_id: params[:auxiliary_table_id]).first
    if @workflow_table
      @workflow_table.destroy
      render json: { data: @workflow_table, klass: 'WorkflowTable' }, status: :ok
    end
  end

  private

  def workflow_table_params
    params.require(:workflow_table).permit!
  end
end
