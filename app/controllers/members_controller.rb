class MembersController < ApplicationController
  before_action :authenticate_user!, only: %i[ edit_description update_description ]

  def show
    @user = User.find(params[:id])
    @connections = Connection.where('user_id = ? OR connected_user_id = ?', params[:id], params[:id]).where(status: 'accepted')
  end

  def edit_description;  end

  def update_description
    respond_to do |format|
      if current_user.update(about: params[:user][:about])
        format.turbo_stream{
          render turbo_stream: turbo_stream.replace(
            "member-description",
            partial: "members/member_description",
            locals: { user: current_user }
          )
        }
      end
    end
  end

  def edit_personal_details; end

  def update_personal_details
    respond_to do |format|
      if current_user.update(user_personal_info_params)
        format.turbo_stream{
          render turbo_stream: turbo_stream.replace(
            'personal-details',
            partial: 'members/personal_details',
            locals: { user: current_user }
          )
        }
      end
    end
  end

  def connections
    @requested_connections = Connection.includes(:requested).where(user_id: params[:id], status: 'accepted')
    @recieved_connections = Connection.includes(:recieved).where(connected_user_id: params[:id], status: 'accepted')
    @total_connnections = @requested_connections.count + @recieved_connections.count
  end

  private

  def user_personal_info_params
    params.require(:user).permit(:first_name, :last_name, :country, :city, :state, :pincode, :profile_title)
  end
end