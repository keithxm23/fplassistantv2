class Player < ActiveRecord::Base
  self.primary_key = "elementid"
  def now_cost_float
    self.now_cost.to_f / 10
  end
  
  #http://stackoverflow.com/a/6892207/1415352
  def as_json(options = { })
    h = super(options)
    h[:now_cost_float] = self.now_cost_float
    h
  end
  
  has_many :performances, :foreign_key => 'player_id',  :inverse_of => :player
  
end
