# frozen_string_literal: true

class UsersController < ApplicationController
  # respond_to :json

  def api_token
    @user = User.find(params[:id])

    respond_to do |format|
      format.json { render json: @user.api_token, status: :ok }
      format.html {}
    end
  end
end
