namespace :teams do
  desc "Seed teams data from squawka"
  task :seed_teams => :environment do
    Team.delete_all

    require 'open-uri'
    require 'json'

    sqwk_teamdata_url = "http://www.squawka.com/wp-content/themes/squawka_web/leaderboard_process-v2.php?type=Team%20Stats&filter=2&league=126&team=0,31,32,302,33,169,34,170,315,36,37,38,39,41,43,44,45,46,47,48,49&played=All%20matches&seasonstart=&seasonend=&by=season&timestart=0&timeend=90&showtype=desc"
    data = JSON.load(open(sqwk_teamdata_url))
    data['result'].delete("sort")
    teamdata = data['result']
    teamdata.keys.each do |key|
      tm = {}
      tm['sqwk_club_id'] = teamdata[key]['info']['club_id']
      tm['sqwk_name'] = teamdata[key]['info']['name']
      tm['sqwk_full_name'] = teamdata[key]['info']['full_name']
      tm['sqwk_club_stats_urls'] = teamdata[key]['info']['club_stats_url']
      Team.create(tm)
    end


    mapping = { #mapping from sqwk_club_id to fpl_team_name
      "31" => "Arsenal",
      "32" => "Aston Villa",
      "33" => "Chelsea",
      "34" => "Everton",
      "36" => "Liverpool",
      "37" => "Man City",
      "38" => "Man Utd",
      "39" => "Newcastle",
      "41" => "QPR",
      "43" => "Southampton",
      "44" => "Stoke",
      "45" => "Sunderland",
      "46" => "Swansea",
      "47" => "Spurs",
      "48" => "West Brom",
      "49" => "West Ham",
      "169" => "Crystal Palace",
      "170" => "Hull",
      "302" => "Burnley",
      "315" => "Leicester"
    }

    acrnym_mapping = { #mapping from sqwk_club_id to fpl_acrynm_name
      "31" => "ARS",
      "32" => "AVL",
      "33" => "CHE",
      "34" => "EVE",
      "36" => "LIV",
      "37" => "MCI",
      "38" => "MUN",
      "39" => "NEW",
      "41" => "QPR",
      "43" => "SOU",
      "44" => "STK",
      "45" => "SUN",
      "46" => "SWA",
      "47" => "TOT",
      "48" => "WBA",
      "49" => "WHU",
      "169" => "CRY",
      "170" => "HUL",
      "302" => "BUR",
      "315" => "LEI"
    }

    mapping.keys.each do |key|
      tm = Team.where(:sqwk_club_id => key).first
      tmplyr = Player.where(:team_name => mapping[key]).first
      tm.fpl_team_id = tmplyr.team_id
      tm.fpl_team_name = tmplyr.team_name
      tm.fpl_team_id = tmplyr.team_id
      tm.fpl_acrynm_name = acrnym_mapping[key]
      tm.save
    end

  end

  task :update_performances => :environment do
    TeamPerformance.delete_all

    require 'open-uri'
    require 'json'

    sqwk_teamdata_url = "http://www.squawka.com/wp-content/themes/squawka_web/leaderboard_process-v2.php?type=Team%20Stats&filter=2&league=126&team=0,31,32,302,33,169,34,170,315,36,37,38,39,41,43,44,45,46,47,48,49&played=All%20matches&seasonstart=&seasonend=&by=season&timestart=0&timeend=90&showtype=desc"
    data = JSON.load(open(sqwk_teamdata_url))
    data['result'].delete("sort")
    teamdata = data['result']
    teamdata.keys.each do |key|
      tm = {}
      tm['sqwk_club_id'] = teamdata[key]['info']['club_id']
      tm['def_avg'] = teamdata[key]['data']['defense_avg']
      tm['att_avg'] = teamdata[key]['data']['attack_avg']
      tm['pos_avg'] = teamdata[key]['data']['possession_avg']
      tm['tot_avg'] = teamdata[key]['data']['total_avg']
      TeamPerformance.create(tm)
    end
  end

end
