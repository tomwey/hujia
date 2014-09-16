class Comment < ActiveRecord::Base
  belongs_to :commentable, :counter_cache => true, :polymorphic => true
  belongs_to :user
  
  # has_one :rating_score
  
  attr_accessible :content, :user_id, :commentable_id, :commentable_type, :is_show_user_info, :overall_rating, :attitude_rating, :service_rating, :env_rating

  default_scope order('created_at DESC')
  scope :visibled, lambda { where( :visible => true ) }

  validates_presence_of :content
  
  validates :overall_rating, numericality: { :greater_than_or_equal_to => 1.0, :less_than_or_equal_to => 5.0 }
  validates :service_rating,numericality: { :greater_than_or_equal_to => 1.0, :less_than_or_equal_to => 5.0 }
  validates :env_rating,numericality: { :greater_than_or_equal_to => 1.0, :less_than_or_equal_to => 5.0 }
  validates :attitude_rating,numericality: { :greater_than_or_equal_to => 1.0, :less_than_or_equal_to => 5.0 }

  def avarge_rating
    (self.overall_rating + self.attitude_rating + self.service_rating + self.env_rating) / 4.0
  end
end
