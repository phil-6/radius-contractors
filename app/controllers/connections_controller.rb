class ConnectionsController < ApplicationController
  before_action :set_user_a, only: %i[ new create]
  before_action :set_connection, only: %i[ destroy ]

  # GET /connections or /connections.json
  def index
    @connections = current_user.connections
  end

  # GET /connections/new
  def new
  end

  # POST /connections or /connections.json
  def create
    respond_to do |format|
      if (@connection = current_user.create_connection_with(@user_a))
        format.html { redirect_to connections_path, success: "Successfully connected with #{@user_a.first_name}" }
        format.json { render :show, status: :created, location: @connection }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @connection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /connections/1 or /connections/1.json
  def destroy
    @connection.destroy!

    respond_to do |format|
      format.html { redirect_to connections_path, status: :see_other, notice: "Connection was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_user_a
      @user_a = User.find_by_id(connection_params)
    end

    def set_connection
      @connection = current_user.connections.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def connection_params
      params.expect([ :user_a_id ])
    end
end
