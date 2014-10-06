namespace :players do
  desc "Populates players data"
  task :populate => :environment do
    
    require 'open-uri'
    require 'json'
    require 'digest'

    BASE_URL = "http://fantasy.premierleague.com/web/api/elements/"
    plyr_count = 1
    players = []
    while true
      #puts plyr_count
      begin
        data = JSON.load(open(BASE_URL+plyr_count.to_s))
        players << data
      rescue Exception => e
        break
      end
      plyr_count += 1
    end
    
    if players.size < 621
      next
    end
    
#     last_hash = Metadata.where(:key=>'last_hash').first
#     if last_hash.nil?
#       last_hash = Metadata.create(:key=>'last_hash')
#       last_hash.save
#     end
#     new_hash = Digest::MD5.hexdigest(players.to_s) 
#     if last_hash.value == new_hash
#       puts "no changes"
#       next
#     else
#       last_hash.value = new_hash
#       last_hash.save
#     end
    
    
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
      "QPR" => "QPR",
      "STK" => "Stoke",
      "SUN" => "Sunderland",
      "WHU" => "West Ham",
      "AVL" => "Aston Villa",
      "WBA" => "West Brom",
      "BUR" => "Burnley",
      "HUL" => "Hull"
      }

    Player.delete_all
    gw_data = {}
    players.each do |p|
      tmp = p.except('fixtures','event_explain','season_history','fixture_history')
      tmp['elementid'] = p['id']
      tmp['summary'] = p['fixtures']['summary'].map{|s| s[1].delete('()').sub(" ", "-")}.join(", ")
      Player.create(tmp.except('id'))
    end
    puts 'dumped all players'
  end
  
  desc "Populates players and player history data"
  task :populate_with_history => :environment do
    
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
        puts e.message
        break
      end
      plyr_count += 1
    end
    
    if players.size < 621
      next
    end
    begin
    
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
      "QPR" => "QPR",
      "STK" => "Stoke",
      "SUN" => "Sunderland",
      "WHU" => "West Ham",
      "AVL" => "Aston Villa",
      "WBA" => "West Brom",
      "BUR" => "Burnley",
      "HUL" => "Hull"
      }
    
    TEAM_IDS = {}
    FULL_TEAM_NAMES.keys.each { |t|
      TEAM_IDS[t] = Team.where(:fpl_acrynm_name => t).first.id
    }

    Player.delete_all
    Performance.delete_all
    gw_data = {}
    players.each do |p|
      tmp = p.except('fixtures','event_explain','season_history','fixture_history')
      tmp['elementid'] = p['id']
      tmp['summary'] = p['fixtures']['summary'].map{|s| s[1].delete('()').sub(" ", "-")}.join(", ")
      Player.create(tmp.except('id'))
      
      p['fixture_history']['all'].each {|f|
        tmpfix = {}
        tmpfix['player_id'] = p['id']
        tmpfix['game_date'] = DateTime.strptime(f[0], "%d %b %H:%M")
        tmpfix['gameweek'] = f[1]
        tmpfix['minutes'] = f[3]
        tmpfix['goals'] = f[4]
        tmpfix['assists'] = f[5]
        tmpfix['clean_sheets'] = f[6]
        tmpfix['conceded'] = f[7]
        tmpfix['own_goals'] = f[8]
        tmpfix['pens_saved'] = f[9]
        tmpfix['pens_missed'] = f[10]
        tmpfix['yellows'] = f[11]
        tmpfix['reds'] = f[12]
        tmpfix['saves'] = f[13]
        tmpfix['bonus'] = f[14]
        tmpfix['esp'] = f[15]
        tmpfix['bps'] = f[16]
        tmpfix['net_transfers'] = f[17]
        tmpfix['value'] = f[18]
        tmpfix['points'] = f[19]
        
        if f[2].include? "(H)"
          tmpfix['at_home'] = true
          tmpfix['opp_team_id'] = TEAM_IDS[f[2].gsub(/\(H\)\s\d+-\d+$/,"")]
          tmpfix['opp_team_name'] = FULL_TEAM_NAMES[f[2].gsub(/\(H\)\s\d+-\d+$/,"")]
        else
          tmpfix['at_home'] = false
          tmpfix['opp_team_id'] = TEAM_IDS[f[2].gsub(/\(A\)\s\d+-\d+$/,"")]
          tmpfix['opp_team_name'] = FULL_TEAM_NAMES[f[2].gsub(/\(A\)\s\d+-\d+$/,"")]
        end
        tmpfix['team_name'] = p['team_name']
        tmpfix['team_goals'] = f[2].gsub(/^\D+/, "").split("-")[0]
        tmpfix['opp_team_goals'] = f[2].gsub(/^\D+/, "").split("-")[1]
        
        Performance.create(tmpfix)
      }
      
      
    end
    puts 'dumped all players and player history'
  rescue Exception => e
    puts e.message
  end
  end
  
  
  
end
