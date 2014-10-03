class Performance < ActiveRecord::Base
  belongs_to :player, :inverse_of => :performances
end
