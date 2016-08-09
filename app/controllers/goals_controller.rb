class GoalsController < ApplicationController
  before_action :check_login

  def new
    @goal = Goal.new
    render :new
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.privacy = (goal_params[:privacy].nil? ? false : true)
    @goal.user_id = current_user.id
    unless @goal.save
      flash[:errors] = @goal.errors.full_messages
    end
    redirect_to goals_url
  end

  def index
    @goals = Goal.all.where(user_id: current_user.id)
  end

  def destroy
    @goal = Goal.find_by(id: params[:id])
    @goal.delete
    redirect_to goals_url
  end

  private

  def goal_params
    params.require(:goal).permit(:title,:body,:privacy)
  end

end
