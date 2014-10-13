

# agent = 'ompatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html'

# p agent =~ /abc|def/

#p "... Indy Library ..." =~  /Indy Library|MJ12bot|AhrefsBot|Wget|^PHP|Ruby|Python/

# p agent =~ /Googlebot|Baiduspider/


# require 'oj'

# hash = {tag:"\"\""}
# p Oj.dump(hash, mode: :compat)

# File.open('body', 'rb') do |fin|
#   str << fin.read
# end

# p strstr = ''


#str = 'abcb'

#str = '许弃用'


#p str.each_char.map(&:ord).inject(:+)


# int1 = 3
# int2 = 3

# p int1 &== int2

# class CurrentUser

#   def initialize(id)
    
#   end

#   def fetch 

#   end

# end

# @current_user = CurrentUser.new(18)


#p @current_user


# class Animal
#   def self.animal_test
#     puts "Animal #{self.name}"
#   end

# end

# class Cat < Animal

#   def self.test
#     puts "Cat #{self.name}"
#     animal_test
#   end
# end


# ani = Animalanimal_test

# ani.test

#puts Cat.superclass.name

# Cat.test


# require "webrick"

# class EnumeratorIOAdapter
#   def initialize(enum)
#     @enum, @buffer, @more = enum, "", true
#   end

#   def read(length=nil, out_buffer="")
#     return nil unless @more
#     until (length && @buffer.length >= length) || !fill_buffer; end
#     if length
#       part = @buffer.slice!(0, length)
#     else
#       part, @buffer = @buffer, ""
#     end
#     out_buffer.replace(part)
#   end

#   def readpartial(length, out_buffer="")
#     raise EOFError if @buffer.empty? && !fill_buffer
#     out_buffer.replace(@buffer.slice!(0, length))
#   end

#   private
#   def fill_buffer
#     @buffer << @enum.next
#   rescue StopIteration
#     @more = false
#   end
# end

# server = WEBrick::HTTPServer.new(Port: 8080)

# server.mount_proc "/" do |request, response|
#   enum = Enumerator.new do |yielder|
#     10.times do
#       sleep 1
#       yielder << "#{Time.now}\r\n"
#     end
#   end

#   response.chunked = true
#   response.body = EnumeratorIOAdapter.new(enum)
# end

# trap(:INT) {server.shutdown}
# server.start


arr = [ [1], [1,2,3], [1,2] ]


arr.sort! { |x,y| y.length <=> x.length }  #=> ["e", "d", "c", "b", "a"]

p arr

