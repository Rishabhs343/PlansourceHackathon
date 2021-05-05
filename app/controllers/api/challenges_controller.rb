# frozen_string_literal: true

module Api
  class ChallengesController < ApplicationController
    before_action :set_challenge, only: %i[show edit update destroy]
    before_action :correct_user, only: %i[edit update destroy]
    helper_method :sort_column, :sort_direction

    # GET /challenges or /challenges.json
    def index
      @challenges = Challenge.order("#{sort_column} #{sort_direction}")
    end

    # GET /challenges/1 or /challenges/1.json
    def show
      @challenges = Challenge.find(params[:id])
      render json: @challenges
    end

    # POST /challenges or /challenges.json
    # Pass data to create 127.0.0.1:3000/api/challenges?api_token=2_QPGqo3UtNwJn3rNP9J
    #   {
    #     "challenge": {
    #         "title": "1322332",
    #         "description": "1233332",
    #         "tags": "Helvetica Arial, sans-serif",
    #         "emp_id": "E24",
    #         "user_id": 24
    #     }
    #   }
    def create
      @challenge = Challenge.new(challenge_params)

      if @challenge.save
        render json: @challenge, status: :created, location: @challenge
      else
        render json: @challenge.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /challenges/1 or /challenges/1.json
    # http://127.0.0.1:3000/api/challenges/19?api_token=2_QPGqo3UtNwJn3rNP9J
    #   {
    #     "challenge": {
    #         "title": "myuserid",
    #         "description": "1233332",
    #         "tags": "Helvetica Arial, sans-serif",
    #         "emp_id": "E24",
    #         "user_id": 24
    #     }
    # }

    def update
      if @challenge.update(challenge_params)
        render json: @challenge
      else
        render json: @challenge.errors, status: :unprocessable_entity
      end
    end

    # DELETE /challenges/1 or /challenges/1.json
    # Delete http://127.0.0.1:3000/api/challenges/20?api_token=2_QPGqo3UtNwJn3rNP9J
    def destroy
      @challenge.destroy
    end

    def correct_user
      @challenge = Challenge.find(params[:id])
      redirect_to challenges_path, notice: 'Not Authorised' if current_user.challenges.find_by(id: params[:id]).nil?
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
end
