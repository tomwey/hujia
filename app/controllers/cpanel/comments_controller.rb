# coding: utf-8
class Cpanel::CommentsController < Cpanel::ApplicationController
  def index
    @comments = Comment.visibled.paginate page: params[:page], per_page: 30
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