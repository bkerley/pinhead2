#!/usr/bin/env ruby

desired = "TheRealQuaid"

check_signature = "uint64_t check(char* got)"

File.open('check.c', 'w') do |c|
  c.puts "#include <stdint.h>"
  c.puts "#include <stdlib.h>"

  sequence = desired.bytes.each_with_index.map do |b, i|
    c.puts "int64_t check_#{i}(int64_t cur) {"
    running = b

    4.times.each do
      operation = %i{+ - * %}.shuffle.first
      operand = rand(2**7) + 1
      result = running.send operation, operand
      c.puts "  // #{running} #{operation} #{operand} => #{result}"
      c.puts "  cur = cur #{operation} #{operand};"
      running = result
    end

    c.puts "  if (#{running} != cur) exit(-1);"
    c.puts "  return cur;"
    c.puts "}"
    c.puts
  end

  c.puts "#{ check_signature } {"
  c.puts "  uint64_t sum = 0;"

  sequence.each_with_index.each do |v, i|
    c.puts "  sum += check_#{i}(got[#{i}]);"
  end

  c.puts "  return sum;"
  c.puts "}"
end

File.open('check.h', 'w') do |c|
  c.puts "#pragma once"
  c.puts "#include <stdint.h>"
  c.puts "#{ check_signature };"
end
