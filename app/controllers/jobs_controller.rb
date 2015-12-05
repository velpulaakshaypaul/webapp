class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /jobs
  # GET /jobs.json
  def index
    @jobs = Job.where(:adminuser_id => current_user.id)
    #@jobs = Job.all
  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show
    @questions=Question.where(:job_id => params[:id])
  end

  # GET /jobs/new
  def new
    @job = Job.new
  end

  # GET /jobs/1/edit
  def edit
  end

  # POST /jobs
  # POST /jobs.json
  def create
    @job = Job.new(job_params)
    @job.adminuser_id = current_user.id
    respond_to do |format|
      if @job.save
          format.html { redirect_to questions_path, notice: 'Job was successfully created.' }
          format.json { render :show, status: :created, location: @job }
      end
    end
  end

  # PATCH/PUT /jobs/1
  # PATCH/PUT /jobs/1.json
  def update
    respond_to do |format|
      if @job.update(job_params)
        format.html { redirect_to @job, notice: 'Job was successfully updated.' }
        format.json { render :show, status: :ok, location: @job }
      else
        format.html { render :edit }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
    @job.destroy
    respond_to do |format|
      format.html { redirect_to jobs_url, notice: 'Job was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def displayapplicantforjob
      @job = Job.find_by_id(params[:job_id])
      @internship_application = InternshipApplication.where(params[:job_id])
      @applicants = Applicant.where(:id => @internship_application.applicant_id)
      render template: "jobs/display_applicant_information"
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_params
      params.require(:job).permit(:id,:title, :description, :qualifications, :jobtype, :postedon, :deadline)
    end

end
