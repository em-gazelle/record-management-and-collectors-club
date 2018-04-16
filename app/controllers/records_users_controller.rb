class RecordsUsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_records_user, only: [:show, :edit, :update, :destroy]
  before_action :check_if_user_permitted_to_change_records_user, only: [:show, :edit, :update, :destroy]

  # GET /records_users
  # GET /records_users.json
  def index
    @records_users = RecordsUser.where(user_id: current_user.id)#current_user.records
    
  end

  def explore
    @analysis_stats_and_recommendations = RecordsUser.record_analysis_stats(current_user.id)
  end

  # GET /records_users/1
  # GET /records_users/1.json
  def show
    @recommended_based_on_most_recently_added_record = RecordsUser.recommended_based_on_most_recently_added_record(current_user.id, @records_user.id)
  end

  # GET /records_users/new
  def new
    @records_user = RecordsUser.new
  end

  # GET /records_users/1/edit
  def edit
  end

  # POST /records_users
  # POST /records_users.json
  def create
    # keep valid records but with user who never provides condition, etc.
    @records_user = RecordsUser.new(records_user_params)
    @records_user.user_id = current_user.id

    if Record.new(record_params).valid? 
        record = Record.find_by(album_title: record_params[:album_title], artist: record_params[:artist], year: record_params[:year]) || Record.create(record_params)
      @records_user.record_id = record.id
    end

    respond_to do |format|
      if @records_user.save
        format.html { redirect_to @records_user, notice: 'Record user was successfully created.' }
        format.json { render :show, status: :created, location: @records_user }
      else
        format.html { render :new }
        format.json { render json: @records_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /records_users/1
  # PATCH/PUT /records_users/1.json
  def update
    @records_user.user_id = current_user.id

    if Record.new(record_params).valid? 
      record = Record.find_by(album_title: record_params[:album_title], artist: record_params[:artist], year: record_params[:year]) || Record.create(record_params)
      @records_user.record_id = record.id
    else
      @records_user.record_id = nil
    end

    respond_to do |format|
      if @records_user.update(records_user_params)
        format.html { redirect_to @records_user, notice: 'Record user was successfully updated.' }
        format.json { render :show, status: :ok, location: @records_user }
      else
        format.html { render :edit }
        format.json { render json: @records_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /records_users/1
  # DELETE /records_users/1.json
  def destroy
    @records_user.destroy
    respond_to do |format|
      format.html { redirect_to records_users_url, notice: 'Record user was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_records_user
      @records_user = RecordsUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def records_user_params
      params[:records_user][:condition] = params[:records_user][:condition].downcase.gsub(' ', '_') if params[:records_user][:condition]

      params.require(:records_user).permit(:condition, :rating, :favorite)
    end
    
    def record_params 
      params.require(:records_user).permit(:album_title, :year, :artist)
    end

    def check_if_user_permitted_to_change_records_user
      unless (@records_user.user_id == current_user.id)
        handle_unauthorized_users
      end
    end

    def handle_unauthorized_users
      respond_to do |format|
        format.html { redirect_to records_users_path, notice: 'You are not authorized to perform this action.' }
        format.json { render json: {}, status: :unauthorized }
      end   
    end

end
