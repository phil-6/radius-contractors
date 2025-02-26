class ContractorsController < ApplicationController
  before_action :set_contractor, only: %i[ show edit update ]

  def index
    @contractors = current_user.viewable_contractors
  end

  def show
    @user_is_customer =  @contractor.customers.include? current_user
    @user_jobs = current_user.jobs.where(contractor_id: @contractor.id)
    @user_rating = current_user.ratings.find_by(contractor_id: @contractor.id)
    @viewable_ratings = @contractor.viewable_ratings(current_user)
  end

  def new
    @contractor = Contractor.new
  end

  def edit
  end

  def create
    @contractor = current_user.contractors.new(contractor_params)

    respond_to do |format|
      if @contractor.save
        format.html { redirect_to @contractor, notice: "Contractor was successfully created." }
        format.json { render :show, status: :created, location: @contractor }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @contractor.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @contractor.assign_attributes(contractor_params)
    @contractor.updated_by_id = current_user.id

    respond_to do |format|
      if @contractor.update(contractor_params)
        format.html { redirect_to @contractor, notice: "Contractor was successfully updated." }
        format.json { render :show, status: :ok, location: @contractor }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @contractor.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contractor
      @contractor = Contractor.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def contractor_params
      params.expect(contractor: [ :name, :number, :email, :town, contractor_trades_attributes: [ :id, :trade_id, :_destroy ] ])
    end
end
