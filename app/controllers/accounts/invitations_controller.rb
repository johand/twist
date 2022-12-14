# frozen_string_literal: true

module Accounts
  class InvitationsController < Accounts::BaseController
    skip_before_action :authorize_user!, only: %i[accept accepted]
    before_action :authorize_owner!, except: %i[accept accepted]

    def new
      @invitation = Invitation.new
    end

    def create
      @invitation = current_account.invitations.new(invitations_params)
      @invitation.save
      InvitationMailer.invite(@invitation).deliver_later.inspect
      flash[:notice] = "#{@invitation.email} has been invited."
      redirect_to root_url
    end

    def accept
      store_location_for(:user, request.fullpath)
      @invitation = Invitation.find_by!(token: params[:id])
    end

    def accepted
      @invitation = Invitation.find_by!(token: params[:id])

      if user_signed_in?
        user = current_user
      else
        user_params = params[:user].permit(
          :email,
          :password,
          :password_confirmation
        )

        user = User.create!(user_params)
        sign_in(user)
      end

      current_account.users << user

      flash[:notice] = "You have joined the #{current_account.name} account."
      redirect_to root_url(subdomain: current_account.subdomain)
    end

    private

    def invitations_params
      params.require(:invitation).permit(:email)
    end
  end
end
