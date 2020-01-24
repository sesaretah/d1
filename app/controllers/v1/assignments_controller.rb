class V1::AssignmentsController < ApplicationController


  def create
    @assignment = Assignment.new(assignment_params)
    if @assignment.save
      render json: { data:  AssignmentSerializer.new(@assignment).as_json, klass: 'Assignment' }, status: :ok
    end
  end

  def destroy
    @assignment = Assignment.find(params[:id])
    if @assignment.destroy
      render json: { data: @assignment, klass: 'Assignment' }, status: :ok
    else
      render json: { data: @assignment.errors.full_messages  }, status: :ok
    end
  end

  def assignment_params
    params.require(:assignment).permit!
  end

end
