class WorkExperiencesController < ApplicationController

  def new
    @work_experience = current_user.work_experiences.new
  end

  def edit; end

  def create; end

  def update; end

  def destroy; end


  private

  def set_work_experience 
    @work_experience = current_user.work_experiences.find(params[:id])
  end

  def work_experiences_params
    params.require(:work_experience).permit(:start_date, :end_date, :currently_working_here, :company, :employment_type, 
      :location, :location_type, :description, :user_id, :job_title)
  end

end