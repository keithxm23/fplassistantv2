class Performance < ActiveRecord::Base
  belongs_to :player, :inverse_of => :performances
  
  def now_cost_float
    self.value.to_f / 10
  end
  
  #http://stackoverflow.com/a/6892207/1415352
  def as_json(options = { })
    h = super(options)
    h[:now_cost_float] = self.now_cost_float
    h
  end
end
