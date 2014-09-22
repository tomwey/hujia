# coding: utf-8
class Cpanel::CommentsController < Cpanel::ApplicationController
  def index
    @comments = Comment.visibled.paginate page: params[:page], per_page: 30
  end
  
  def edit
    @comment = Comment.find(params[:id])
  end
  
  def update
    @comment = Comment.find(params[:id])
    if @comment.update_attributes(params[:comment])
      redirect_to cpanel_comments_path, notice: "Updated successfully."
    else
      render :edit
    end
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    @comment.visible = false
    if @comment.save
      render :text => "1"
    else
      render :text => "-1"
    end
    
  end
end