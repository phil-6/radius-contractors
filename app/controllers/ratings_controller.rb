class RatingsController < ApplicationController
  before_action :set_contractor
  before_action :set_rating, only: %i[ edit update ]

  # GET /ratings/new
  def new
    @rating = @contractor.ratings.new
  end

  # GET /ratings/1/edit
  def edit; end

  # POST /ratings or /ratings.json
  def create
    @rating = @contractor.ratings.new(rating_params)
    @rating.user = current_user

    respond_to do |format|
      if @rating.save
        format.html { redirect_to @contractor, success: "Rating was successfully created." }
        format.json { render :show, status: :created, location: @rating }
      else
        format.html { render :new, status: :unprocessable_entity, error: "Something went wrong creating your rating." }
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ratings/1 or /ratings/1.json
  def update
    respond_to do |format|
      if @rating.update(rating_params)
        format.html { redirect_to @contractor, success: "Rating was successfully updated." }
        format.json { render :show, status: :ok, location: @rating }
      else
        format.html { render :edit, status: :unprocessable_entity, error: "Something went wrong updating your rating." }
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_contractor
    @contractor = Contractor.find(params.expect(:contractor_id))
  end

  def set_rating
    @rating = @contractor.ratings.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def rating_params
    params.expect(rating: %i[review overall_rating value_rating communication_rating quality_rating tidiness_rating professionalism_rating])
  end
end
