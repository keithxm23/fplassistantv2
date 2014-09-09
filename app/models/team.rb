class Team < ActiveRecord::Base
  self.primary_key = "sqwk_club_id"
  has_one :team_performance, :class_name => 'TeamPerformance',
    :foreign_key => 'sqwk_club_id',  :inverse_of => :team
end
