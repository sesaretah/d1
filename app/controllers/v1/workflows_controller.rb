class V1::WorkflowsController < ApplicationController

  def index
    @workflows = Workflow.all
    render json: { data: @workflows, model: 'Workflow' }, status: :ok
  end

  def create
    @workflow = Workflow.create(workflow_params)
    render json: { data: @workflow, model: 'Workflow' }, status: :ok
  end

  def show
    @workflow = Workflow.find(params[:id])
    render json: { data: {workflow: @workflow, nodes: @workflow.nodes, edges: @workflow.edges}, model: 'Workflow' }, status: :ok
  end


  def update
    @workflow = Workflow.find(params[:id])
    if @workflow.update_attributes(workflow_params)
      render json: { data: @workflow, model: 'Workflow' }, status: :ok
    else
      render json: { data: @workflow.errors.full_messages  }, status: :ok
    end
  end


  private

  def workflow_params
    params.require(:workflow).permit!
  end
end
