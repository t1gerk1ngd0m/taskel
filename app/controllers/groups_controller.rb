class GroupsController < ApplicationController
  before_action :set_group, only: [:edit, :update, :destroy]

  def index
    @groups = current_user.groups.all
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
      redirect_to groups_path
    else
      flash[:failed] = t 'groups.create.failed'
      @group_users = User.all
      render action: :new
    end
  end

  def edit
    @group_users = User.all
  end

  def update
    if @group.update(group_params)
      flash[:success] = t 'groups.update.success'
      redirect_to groups_path
    else
      flash[:failed] = t 'groups.update.failed'
      @group_users = User.all
      render action: :edit
    end
  end

  def destroy
    if @group.destroy
      flash[:success] = t 'groups.destroy.success'
      redirect_to groups_path
    else
      flash[:failed] = t 'groups.destroy.failed'
      render action: :index
    end
  end

  private
  def group_params
    params.require(:group).permit(
      :name, 
      { user_ids: [] }
    )
  end

  def set_group
    @group = Group.find(params[:id])
  end
end
