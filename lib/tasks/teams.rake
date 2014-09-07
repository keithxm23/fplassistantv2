namespace :teams do
  desc "Seed teams data from squawka"
  task :seed => :environment do
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
