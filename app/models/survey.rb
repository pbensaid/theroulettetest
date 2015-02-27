class Survey < ActiveRecord::Base

  validates :options, :name, presence: true
    has_many :options, :dependent => :destroy
  accepts_nested_attributes_for :options, :reject_if => proc { |a| a[:content].blank? }, :allow_destroy => true
  paginates_per 50

  def to_param
    Hashids.new("three options good", 5).encode(id)
  end

end
