namespace :gameweeks do
  desc "Populates Gameweek data"
  task :populate => :environment do

    require 'open-uri'
    require 'json'
    require 'digest'

    BASE_URL = "http://fantasy.premierleague.com/web/api/elements/"
    plyr_count = 1
    players = []
    while true
      puts plyr_count
      begin
        data = JSON.load(open(BASE_URL+plyr_count.to_s))
        players << data
      rescue Exception => e
        break
      end
      plyr_count += 1
    end

    if players.size < 620
      puts "player size <620"
      next
    end


    FULL_TEAM_NAMES = {
      "ARS" => "Arsenal",
      "CRY" => "Crystal Palace",
      "EVE" => "Everton",
      "LEI" => "Leicester",
      "TOT" => "Spurs",
      "SOU" => "Southampton",
      "CHE" => "Chelsea",
      "MCI" => "Man City",
      "MUN" => "Man Utd",
      "LIV" => "Liverpool",
      "SWA" => "Swansea",
      "NEW" => "Newcastle",
#       "QPR" => "QPR",
      "STK" => "Stoke",
      "SUN" => "Sunderland",
      "WHU" => "West Ham",
      "AVL" => "Aston Villa",
      "WBA" => "West Brom",
#       "BUR" => "Burnley",
#       "HUL" => "Hull",
      "WAT" => "Watford",
      "BOU" => "Bournemouth",
      "NOR" => "Norwich"
      }

    Gameweek.delete_all
    gw_data = {}
    players.each do |p|
      tmp = p.except('fixtures','event_explain','season_history','fixture_history')
      tmp['elementid'] = p['id']
      tmp['summary'] = p['fixtures']['summary'].map{|s| s[1].delete('()').sub(" ", "-")}.join(", ")

      unless gw_data.has_key?(p['team_name']) or p['status'] != "a"

        all_fixs = p['fixtures']['all']
        all_fixs.each do |fix|
          next if fix[0] == "-"
          gw = {}
          gw['at'] = DateTime.strptime(fix[0], "%d %b %H:%M")
          #TODO if date < aug, set to 2015
          gw['gw_num'] = fix[1].gsub("Gameweek ", "")
          if fix[2].include? "(H)"
            gw['home_team'] = p['team_name']
            gw['away_team'] = fix[2].gsub(" (H)", "")
          else
            gw['away_team'] = p['team_name']
            gw['home_team'] = fix[2].gsub(" (A)", "")
          end
          Gameweek.create(gw)
        end

        all_fixs = p['fixture_history']['all']
        all_fixs.each do |fix|
          gw = {}
          gw['at'] = DateTime.strptime(fix[0], "%d %b %H:%M")
          #TODO if date < aug, set to 2015
          gw['gw_num'] = fix[1]
          if fix[2].include? "(H)"
            gw['home_team'] = p['team_name']
            gw['away_team'] = FULL_TEAM_NAMES[fix[2].gsub(/\(H\)\s\d+-\d+$/,"")]
          else
            gw['away_team'] = p['team_name']
            gw['home_team'] = FULL_TEAM_NAMES[fix[2].gsub(/\(A\)\s\d+-\d+$/,"")]
          end
          gw['home_goals'] = fix[2].gsub(/^\D+/, "").split("-")[0]
          gw['away_goals'] = fix[2].gsub(/^\D+/, "").split("-")[1]
          Gameweek.create(gw)
        end
        gw_data[p['team_name']] = nil

      end
    end
    Gameweek.dedupe
  end
end
