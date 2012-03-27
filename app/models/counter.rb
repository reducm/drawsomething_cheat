class Counter < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true 
   
  def self.visit
    if mcount = $redis.get( "visit_count" )
      mcount = mcount.to_i + 1
      $redis.set "visit_count", mcount
      mcount 
    else
      c = Counter.find_by_name('visit')
      c = Counter.create(name:'visit',count:0) unless c
      $redis.set "visit_count", c.count
      c.count
    end
  end

  def self.save_visit()
    mcount = $redis.get "visit_count"
    c = Counter.find_by_name('visit')
    c.count = mcount
    c.save
  end
end
