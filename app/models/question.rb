class Question < ApplicationRecord
  belongs_to :user
  validates :text, :user, presence: true
  validates_length_of :text, :minimum => 6, :maximum => 255
end
