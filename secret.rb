require 'json'

# Note: Get it here: https://github.com/C-Bouthoorn/Ruby-Frameworks
require 'FileIO.rb';

def merge x, y
  data=[ x.split("\n"), y.split("\n") ]

  [data[0].length, data[1].length].max.times do |i|
    data[0][i]="" if data[0][i]==nil
    data[0][i]+=data[1][i]
  end

  return data[0].join "\n"
end

def main args
  fio=FileIO.new "data.json"
  content=fio.getContent.join ''
  json=JSON.parse content

  word=json['word']
  settings=json['settings']
  chars=json['chars']
  pattern=json['pattern']
  data=json['data']

  if settings['word-to-uppercase']
    word=word.upcase
  end

  matches=''
  data.each_key do |key|
    matches+=key
  end

  word=word.scan(/[#{matches}]/).join ''

  output=""
  word.each_char.with_index do |char, ix|
    enabled=data[char]
    temp=""

    last=[]
    pattern.each do |line|
      last.push line[-1]
    end

    pattern.flatten.each do |loc|
      if enabled.include? loc
        temp+=chars[0]
      else
        temp+=chars[1]
      end

      if last.include? loc
        temp+="\n"
      end
    end

    output=merge(output, temp)
    lines="-\n-\n-\n-\n-"
    output=merge(output, lines) if ix < word.length-1
  end

  if settings['equal-amount-of-dashes-per-line']
    max=0
    output=output.split "\n"

    output.each do |line|
      max=line.count('-') if line.count('-') > max
    end

    output.each.with_index do |line, ix|
      dash='-' * ( max - line.count('-') )
      output[ix]+=dash
    end

    output=output.join "\n"
  end

  puts output
end

main ARGV
