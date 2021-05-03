# frozen_string_literal: true

class ChallengesController < ApplicationController
  before_action :set_challenge, only: %i[show edit update destroy]
  before_action :correct_user, only: %i[edit update destroy]
  helper_method :sort_column, :sort_direction

  # GET /challenges or /challenges.json
  def index
    @challenges = Challenge.order("#{sort_column} #{sort_direction}")
    @challenge = current_user.challenges.build
  end

  # GET /challenges/1 or /challenges/1.json
  def show; end

  # GET /challenges/new
  def new
    # @challenge = Challenge.new
    @challenge = current_user.challenges.build
  end

  # GET /challenges/1/edit
  def edit; end

  # POST /challenges or /challenges.json
  def create
    # @challenge = Challenge.new(challenge_params)
    @challenge = current_user.challenges.build(challenge_params)

    respond_to do |format|
      if @challenge.save
        format.html { redirect_to root_path, notice: 'Challenge was successfully created.' }
        format.json { render :show, status: :created, location: @challenge }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @challenge.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /challenges/1 or /challenges/1.json
  def update
    respond_to do |format|
      if @challenge.update(challenge_params)
        format.html { redirect_to @challenge, notice: 'Challenge was successfully updated.' }
        format.json { render :show, status: :ok, location: @challenge }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @challenge.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /challenges/1 or /challenges/1.json
  def destroy
    @challenge.destroy
    respond_to do |format|
      format.html { redirect_to challenges_url, notice: 'Challenge was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def correct_user
    @challenge = Challenge.find(params[:id])
    if current_user.following?(@challenge)

    elsif current_user.challenges.find_by(id: params[:id]).nil?
      redirect_to challenges_path, notice: 'Not Authorised'
    end
  end

  def upvote
    @challenge = Challenge.find(params[:id])
    @challenge.upvote_by(current_user)
    redirect_to challenges_path
  end

  def follow
    @challenge = Challenge.find(params[:id])
    current_user.follow(@challenge)
    redirect_to challenges_path
  end

  def search
    if params[:search].blank?
      redirect_to(root_path, notice: 'Empty field!') and return
    else
      @parameter = params[:search].downcase
      @challenges = Challenge.all.where('lower(title) LIKE :search', search: "%#{@parameter}%")
      @challenge = current_user.challenges.build
    end
  end

  private

  def sort_column
    Challenge.column_names.include?(params[:sort]) ? params[:sort] : 'id'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_challenge
    @challenge = Challenge.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def challenge_params
    params.require(:challenge).permit(:title, :description, :tags, :emp_id, :user_id)
  end
end
