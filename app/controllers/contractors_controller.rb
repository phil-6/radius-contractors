class ContractorsController < ApplicationController
  before_action :set_contractor, only: %i[ show edit update ]
  before_action :set_trades, only: %i[ new edit update ]

  def index
    @contractors = current_user.viewable_contractors
    # @trades = @contractors.map(&:trades).flatten.uniq # Neater but less efficient
    @trades = Trade.where(id: @contractors.joins(:contractor_trades).select(:trade_id))
    @contractors = @contractors.joins(:contractor_trades).where(contractor_trades: { trade_id: params[:trade_id] }) if params[:trade_id].present?
  end

  def show
    @user_is_customer = @contractor.customers.include? current_user
    @user_jobs = current_user.jobs.where(contractor_id: @contractor.id)
    @user_rating = current_user.ratings.find_by(contractor_id: @contractor.id)
    @viewable_ratings = @contractor.viewable_ratings(current_user)
  end

  def new
    @contractor = Contractor.new
  end

  def edit
    @contractor_trades = @contractor.contractor_trades
  end

  def create
    @contractor = Contractor.where("number = ? OR email = ?", contractor_params[:number], contractor_params[:email]).first_or_initialize
    redirect_to @contractor, info: "We found an existing contractor that matched some of the details you entered. You can add a job for this contractor below." and return if @contractor.persisted?

    @contractor.assign_attributes(contractor_params.merge(added_by: current_user))
    respond_to do |format|
      if @contractor.save
        format.html { redirect_to @contractor, notice: "Contractor was successfully created." }
        format.json { render :show, status: :created, location: @contractor }
      else
        @trades = Trade.all
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @contractor.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @contractor.assign_attributes(contractor_params)
    @contractor.trade_ids = contractor_params[:trade_ids]
    @contractor.updated_by_id = current_user.id

    respond_to do |format|
      if @contractor.save
        format.html { redirect_to @contractor, notice: "Contractor was successfully updated." }
        format.json { render :show, status: :ok, location: @contractor }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @contractor.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_contractor
    @contractor = Contractor.find(params.expect(:id))
  end

  def set_trades
    @trades = Trade.all
  end

  # Only allow a list of trusted parameters through.
  def contractor_params
    params.expect(contractor: [ :name, :number, :email, :town, trade_ids: [] ])
  end
end
