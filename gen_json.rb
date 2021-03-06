# encoding: utf-8
#!/usr/local/bin/ruby

require 'json'

respostas = {}
log = File.new("/tmp/filtered_chat.log", "r")
pergunta = ''
while (line = log.gets)
  begin
    line.force_encoding "UTF-8"

    if line.include? 'Tema'
      pergunta = line.split(' ')[4..-1].join(' ')
      respostas[pergunta] ||= []
    else
      respostas[pergunta] << line.gsub(' ', ' ').strip.downcase
      respostas[pergunta].uniq!
    end
  rescue Exception => e
    puts e.inspect
  end
end
log.close

json = File.new('respostas.json','w')
json.write(respostas.to_json)
json.close
