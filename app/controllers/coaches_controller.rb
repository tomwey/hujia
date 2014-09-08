# coding: utf-8
class CoachesController < ApplicationController

  before_filter :validate_search_key, only: [:index, :college]
  
  helper_method :sort_column, :sort_direction
  
  
  def index
        
    @coaches = Coach.search(@query_string)
    
    # 驾照
    if params[:dt].present?
      @coaches = @coaches.where(:drive_type => params[:dt])
    end
    
    # 交通
    if params[:st].present?
      @coaches = @coaches.where(:service_type => params[:st])
    end
    
    # 价格
    if params[:price].present?
      values = params[:price].split('-')
      if values.count == 1
        low = values.first.to_i
        @coaches = @coaches.where('price >= ?', low)
      elsif values.count == 2
        low = values.first.to_i
        max = values.last.to_i
        if low < max
          @coaches = @coaches.where('price between ? and ?', low, max)
        else
          @coaches = @coaches.where('price between ? and ?', max, low)
        end
      end
      
    end
    
    # 大学校区过滤
    if params[:c].present?
      @coaches = @coaches.joins(:service_areas).where('colleges.name = ?', params[:c])
    end
    
    @coaches = @coaches.includes(:coupons, :comments)
    @coaches = @coaches.order(sort_column + " " + sort_direction).paginate(:page => params[:page], :per_page => 3)
    
    @pages   = Page.where('slug like ?', "%xyxz%").order('sort asc')
  end
  
  def show
    @coach = Coach.find(params[:id])
  end
  
  
  def comments
    @coach = Coach.find_by_id(params[:id])
  end
  
  private
  def sort_column
    type = params[:type] || "coach"
    type_class = type.camelize.constantize
    
    type_class.column_names.include?(params[:sort]) ? params[:sort] : "sort"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end
  
  protected
  def validate_search_key
    @query_string = params[:q].gsub(/\\|\'|-|\/|\.|\?/, "") if params[:q].present?
  end
  
end