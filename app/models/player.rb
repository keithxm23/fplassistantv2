class Player < ActiveRecord::Base
  def now_cost_float
    self.now_cost.to_f / 10
  end
  
  #http://stackoverflow.com/a/6892207/1415352
  def as_json(options = { })
    h = super(options)
    h[:now_cost_float] = self.now_cost_float
    h
  end
end
