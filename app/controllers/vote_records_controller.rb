class VoteRecordsController < ApplicationController
  before_action :set_vote_record, only: [:show, :edit, :update, :destroy]

  # GET /vote_records
  # GET /vote_records.json
  def index
    @vote_records = VoteRecord.all
  end

  # GET /vote_records/1
  # GET /vote_records/1.json
  def show
  end

  # GET /vote_records/new
  def new
    @vote_record = VoteRecord.new
  end

  # GET /vote_records/1/edit
  def edit
  end

  # POST /vote_records
  # POST /vote_records.json
  def create
    @vote_record = VoteRecord.new(vote_record_params)

    respond_to do |format|
      if @vote_record.save
        format.html { redirect_to @vote_record, notice: 'Vote record was successfully created.' }
        format.json { render action: 'show', status: :created, location: @vote_record }
      else
        format.html { render action: 'new' }
        format.json { render json: @vote_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vote_records/1
  # PATCH/PUT /vote_records/1.json
  def update
    respond_to do |format|
      if @vote_record.update(vote_record_params)
        format.html { redirect_to @vote_record, notice: 'Vote record was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @vote_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vote_records/1
  # DELETE /vote_records/1.json
  def destroy
    @vote_record.destroy
    respond_to do |format|
      format.html { redirect_to vote_records_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vote_record
      @vote_record = VoteRecord.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vote_record_params
      params.require(:vote_record).permit(:user_id, :venue_id, :is_yes)
    end
end
