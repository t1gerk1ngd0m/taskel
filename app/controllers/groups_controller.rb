class GroupsController < ApplicationController

  def index
    @group = current_user.groups.all
  end
  
  def new
    @group = current_user.groups.build
    @group.users << current_user
    @group_users = User.all
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      flash[:success] = t 'groups.create.success'
      binding.pry
      redirect_to group_path
    elsif
      # flash[:failed] = t 'groups.create.failed'
      binding.pry
      render :new
    end
  end

  private
  def group_params
    params.require(:group).permit(
      :name, 
      { user_ids: [] }
    )
  end
end
