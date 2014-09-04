# coding: utf-8
class SchoolsController < ApplicationController

  before_filter :require_user, only: [:comments]
  
  layout 'user_layout', only: [:comments]
  
  def show
    @school = School.find(params[:id])
  end
  
  
  def comments
    @commentable = School.find_by_id(params[:id])
    @comment = Comment.new(:commentable_type => @commentable.class.name, 
                           :commentable_id => @commentable.id)
  end
  
end