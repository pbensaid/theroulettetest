class Vote < ActiveRecord::Base
  belongs_to :option, :counter_cache => true
end
