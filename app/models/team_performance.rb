class TeamPerformance < ActiveRecord::Base
  belongs_to :team, :class_name => 'Team',  :foreign_key => 'sqwk_club_id',
   :inverse_of => :team_performance
end
