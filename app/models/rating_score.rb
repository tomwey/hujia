class RatingScore < ActiveRecord::Base
  attr_accessible :comment_id, :score, :user_id
  
  # belongs_to :comment
end
