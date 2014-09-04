class StarItem < ActiveRecord::Base
  attr_accessible :comment_id, :name, :score, :summary
  
  belongs_to :comment
  
end
