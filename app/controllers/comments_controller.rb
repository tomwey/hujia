# coding: utf-8
class CommentsController < ApplicationController
  before_filter :require_user
  
  def create
    @comment = Comment.new(params[:comment])
    @comment.user_id = current_user.id
    @success = @comment.save
  end
  
end