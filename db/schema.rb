# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141003030555) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "gameweeks", force: true do |t|
    t.integer  "gw_num"
    t.string   "home_team"
    t.string   "away_team"
    t.datetime "at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "home_goals"
    t.integer  "away_goals"
  end

  create_table "metadata", force: true do |t|
    t.string   "key"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "performances", force: true do |t|
    t.date     "game_date"
    t.integer  "gameweek"
    t.integer  "opp_team_id"
    t.boolean  "at_home"
    t.integer  "team_goals"
    t.integer  "opp_team_goals"
    t.integer  "minutes"
    t.integer  "goals"
    t.integer  "assists"
    t.integer  "clean_sheets"
    t.integer  "conceded"
    t.integer  "own_goals"
    t.integer  "pens_saved"
    t.integer  "pens_missed"
    t.integer  "yellows"
    t.integer  "reds"
    t.integer  "saves"
    t.integer  "bonus"
    t.integer  "esp"
    t.integer  "bps"
    t.integer  "net_transfers"
    t.float    "value"
    t.integer  "points"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "player_id"
    t.string   "team_name"
    t.string   "opp_team_name"
  end

  create_table "players", force: true do |t|
    t.string   "first_name"
    t.string   "second_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "elementid"
    t.integer  "transfers_out"
    t.integer  "code"
    t.integer  "event_total"
    t.string   "web_name"
    t.boolean  "in_dreamteam"
    t.integer  "team_code"
    t.integer  "transfers_out_event"
    t.integer  "total_points"
    t.string   "type_name"
    t.string   "team_name"
    t.string   "status"
    t.float    "form"
    t.string   "current_fixture"
    t.integer  "now_cost"
    t.float    "points_per_game"
    t.integer  "transfers_in"
    t.text     "news"
    t.integer  "event_points"
    t.string   "next_fixture"
    t.integer  "transfers_in_event"
    t.float    "selected_by"
    t.integer  "team_id"
    t.integer  "yellow_cards"
    t.integer  "goals_conceded"
    t.text     "photo"
    t.integer  "red_cards"
    t.integer  "saves"
    t.float    "chance_of_playing_this_round"
    t.float    "chance_of_playing_next_round"
    t.float    "value_form"
    t.float    "value_season"
    t.float    "cost_change_start"
    t.float    "cost_change_event"
    t.float    "cost_change_start_fall"
    t.float    "cost_change_event_fall"
    t.integer  "dreamteam_count"
    t.float    "selected_by_percent"
    t.float    "ep_this"
    t.float    "ep_next"
    t.boolean  "special"
    t.integer  "minutes"
    t.integer  "goals_scored"
    t.integer  "assists"
    t.integer  "clean_sheets"
    t.integer  "own_goals"
    t.integer  "penalties_saved"
    t.integer  "penalties_missed"
    t.integer  "bonus"
    t.integer  "ea_index"
    t.integer  "bps"
    t.integer  "element_type"
    t.integer  "team"
    t.string   "summary"
  end

  create_table "team_performances", force: true do |t|
    t.integer "sqwk_club_id"
    t.float   "def_avg"
    t.float   "att_avg"
    t.float   "pos_avg"
    t.float   "tot_avg"
  end

  create_table "teams", force: true do |t|
    t.integer  "sqwk_club_id"
    t.integer  "fpl_team_id"
    t.string   "sqwk_name"
    t.string   "sqwk_full_name"
    t.string   "fpl_acrynm_name"
    t.string   "fpl_team_name"
    t.string   "sqwk_club_stats_urls"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
