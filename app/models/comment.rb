class Comment < ActiveRecord::Base
  belongs_to :commentable, :counter_cache => true, :polymorphic => true
  belongs_to :user
  
  has_many :star_items, :dependent => :destroy
  
  attr_accessible :content, :user_id, :commentable_id, :commentable_type, :overall_rating, :attitude_rating, :service_rating, :env_rating

  validates_presence_of :content

  def avarge_rating
    (self.overall_rating + self.attitude_rating + self.service_rating + self.env_rating) / 4.0
  end
end
