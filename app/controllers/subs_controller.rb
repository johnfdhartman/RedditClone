class SubsController < ApplicationController
  before_action only: [:update] do
    @sub = Sub.find(params[:id])
    require_moderator(@sub)
  end

  before_action :require_login, only: [:new, :create]

  def new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def index
  end

  def show
    @sub = Sub.find(params[:id])
  end

  def edit
    @sub = Sub.find(params[:id])
  end

  def update
  end

  def require_moderator(sub)
    unless current_user == sub.moderator
      redirect_to sub_url(sub)
    end
  end

  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
