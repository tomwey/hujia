# coding: utf-8
class SearchController < ApplicationController
  
  before_filter :validate_search_key
  
  helper_method :sort_column, :sort_direction
  
  def index
    if @query_string.present?
      # @search = Ransack::Search.new(Coach, @search_criteria)
      # @coaches = @search.result(:distinct => true).paginate(:page => params[:page], :per_page => 20)
      
      # @search.build_sort if @search.sorts.empty?
      
      type = params[:type] || "coach"
      
      type_class = type.camelize.constantize

      @results = type_class.search(@query_string)
      
      if params[:dt].present?
        @results = @results.where(:drive_type => params[:dt])
      end
      
      if params[:st].present?
        @results = @results.where(:service_type => params[:st])
      end
      
      if params[:price].present?
        values = params[:price].split('-')
        if values.count == 1
          low = values.first.to_i
          @results = @results.where('price >= ?', low)
        elsif values.count == 2
          low = values.first.to_i
          max = values.last.to_i
          if low < max
            @results = @results.where('price between ? and ?', low, max)
          else
            @results = @results.where('price between ? and ?', max, low)
          end
        end
        
      end
       
      if params[:c].present?
        @results = @results.joins(:service_areas).where('colleges.name = ?', params[:c])
      end
      
      @results = @results.order(sort_column + " " + sort_direction).paginate(:page => params[:page], :per_page => 3)
    end
  end

  def coaches
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
