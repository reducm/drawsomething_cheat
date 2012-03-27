# encoding: UTF-8
class Draw < ActiveRecord::Base
  validates :letters, :presence => {:message=>'字符不能为空！' }, :format => {:with => /[a-zA-z]+/,:message=>'不能输入字母以外的字符！'}, :length=>{:minimum=>2, :maximum=>20, :message => '请输入2-20个数范围内的字符'  } 
  validates :count, :numericality => {:message=>'输入的字符不是一个合法的数字'} 

  attr_accessor :letters, :count

  def receive(letters,count)
    temp_keys = getKeys(count)
    temp_keys = temp_keys.reject do |key|
        key =~ /[^#{letters}]/
    end
    temp_map = {}
    letters_arr = letters.split('')
    temp_keys.each do|t| 
      tt = t.split('')
      next if (letters_arr - (letters_arr - tt)).length < tt.length #筛选走子集有相同的字符而超集没有
      temp_map[t] = $redis.get t
    end
    temp_map
  end

  def getKeys(count)
    count = count.to_i
    if $redis.get('jas')
      a = $redis.keys 
      a = a.select{|t| t.length == count}
    else
      a = []
      ds = Draw.all(:select => "english,chinese")
      ds.each do|d| 
        $redis.set(d.english, d.chinese)
        a<<d.english
      end
      ds = nil
      $redis.set('jas','这个app的制作者')
      a = a.select{|t| t.length == count}
    end
  end
end
