class JobsController < ApplicationController
  before_action :set_contractor
  before_action :set_job, only: %i[ edit update destroy ]

  # GET /jobs/new
  def new
    @job = @contractor.jobs.new
  end

  # GET /jobs/1/edit
  def edit; end

  # POST /jobs or /jobs.json
  def create
    @job = @contractor.jobs.new(job_params)
    @job.user = current_user

    respond_to do |format|
      if @job.save
        format.html { redirect_to @contractor, notice: "Job was successfully created." }
        format.json { render :show, status: :created, location: @job }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jobs/1 or /jobs/1.json
  def update
    respond_to do |format|
      if @job.update(job_params)
        format.html { redirect_to @contractor, notice: "Job was successfully updated." }
        format.json { render :show, status: :ok, location: @job }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1 or /jobs/1.json
  def destroy
    @job.destroy!

    respond_to do |format|
      format.html { redirect_to contractor_path(@contractor), status: :see_other, notice: "Job was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_contractor
    @contractor = Contractor.find(params.expect(:contractor_id))
  end

  def set_job
    @job = @contractor.jobs.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def job_params
    params.expect(job: %i[description state start_date end_date review])
  end
end
