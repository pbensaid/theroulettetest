class Option < ActiveRecord::Base
  belongs_to :survey
  has_many :votes, :dependent => :destroy
  accepts_nested_attributes_for :votes, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true
end
