class Gameweek < ActiveRecord::Base

  # http://stackoverflow.com/questions/14124212/remove-duplicate-records-based-on-multiple-columns
  def self.dedupe
    # find all models and group them on keys which should be common
    grouped = all.group_by{|model| [model.home_team, model.away_team] }
    grouped.values.each do |duplicates|
      # the first one we want to keep right?
      first_one = duplicates.shift # or pop for last one
      # if there are any more left, they are duplicates
      # so delete all of them
      duplicates.each{|double| double.destroy} # duplicates can now be destroyed
    end
  end

end
