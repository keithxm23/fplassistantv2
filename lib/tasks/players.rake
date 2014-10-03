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
      rescue OpenURI::HTTPError => e
        break
      end
      plyr_count += 1
    end
    
    if players.size < 617
      next
    end
    
    last_hash = Metadata.where(:key=>'last_hash').first
    if last_hash.nil?
      last_hash = Metadata.create(:key=>'last_hash')
      last_hash.save
    end
    new_hash = Digest::MD5.hexdigest(players.to_s) 
    if last_hash.value == new_hash
      puts "no changes"
      next
    else
      last_hash.value = new_hash
      last_hash.save
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
end
