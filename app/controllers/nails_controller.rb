class NailsController < ApplicationController

  def index
    @nails = Nail.page(params[:page])
    @nails = Nail.includes(:favorited_users).sort {|a,b| b.favorited_users.size <=> a.favorited_users.size}
  end

  def edit
    @nail = Nail.find(params[:id])
  end

  def update
    @nail = Nail.find(params[:id])
    @nail.update(nail_params)
    redirect_to nail_path(@nail.id)
  end

  def show
    @nail = Nail.find(params[:id])
    @nail_comment = NailComment.new
  end

  def new
    @nail = Nail.new
  end

  def create
    @nail = Nail.new(nail_params)
    @nail.user_id = current_user.id
    if @nail.save
     redirect_to nail_path(@nail.id)
    else
     render :new
    end
  end

  def destroy
    @nail = Nail.find(params[:id])
    @nail.destroy
    redirect_to nails_path
  end

  private
  def nail_params
    params.require(:nail).permit(:image, :introduction)
  end
end
