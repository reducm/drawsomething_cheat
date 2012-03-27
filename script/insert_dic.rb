# encoding: UTF-8
require 'mysql2'
c = Mysql2::Client.new(username:'scott',password:'tiger',database:'draw_something')
c.query('set names utf8')
sql = 'insert into draws(english,chinese) values'
File.open('yinghan_done.txt','r') do |f|
    f.each_line.with_index do |line,i|
	m = /[a-z]+/.match(line)
	m2 = /\.(.+)/.match(line)
	if m && m2
#	    p "english:#{m[0]}   chinese:#{m2[1]}   #{i}行"
	   sql_temp = "('#{m[0]}','#{m2[1]}')," 
	   sql << sql_temp
	end
    end
end

sql = /(.*),$/.match(sql)[1]
p sql
r = c.query(sql)
p r


=begin
str = IO.read('yinghan.txt')
str = str.gsub(/\r/,'')
File.open('yinghan_new.txt','w'){|f| f.puts(str)}
=end

=begin
str = IO.read('yinghan_new.txt')
str = str.gsub(/^((n\.)|(adj\.)|(adv\.)|(v\.)).*?\n/,'')
File.open('yinghan_done.txt', 'w+'){|f| f.puts(str)}
=end
