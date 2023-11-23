class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :team_member
  
  validates :content, presence: true
end
