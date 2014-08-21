namespace :players do
  desc "TODO"
  task :populate => :environment do
    Player.delete_all
    UpcomingGameweek.delete_all
    players = JSON.parse(IO.read('data.json'))
    gw_data = {}
    players.each do |p|
      tmp = p.except('fixtures','event_explain','season_history','fixture_history')
      tmp['elementid'] = p['id']
      tmp['summary'] =  p['fixtures']['summary'].map{|s| s[1].delete('()').sub(" ", "-")}.join(", ")
      Player.create(tmp.except('id'))

      unless gw_data.has_key? p['team_name']
        all_fixs = p['fixtures']['all']
        all_fixs.each do |fix|
          gw = {}
          gw['at'] = DateTime.strptime(fix[0], "%d %b %H:%M")
          gw['gw_num'] = fix[1].gsub("Gameweek ", "")
          if fix[2].include? "(H)"
            gw['home_team'] = p['team_name']
            gw['away_team'] = fix[2].gsub(" (H)", "")  
          else
            gw['away_team'] = p['team_name']
            gw['home_team'] = fix[2].gsub(" (A)", "")
          end
          UpcomingGameweek.create(gw)
        end
        gw_data[p['team_name']] = nil
      end
    end
    UpcomingGameweek.dedupe
  end
end
