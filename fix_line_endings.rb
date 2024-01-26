Dir.glob('**/*.*').each do |file|
  content = File.read(file)
  updated_content = content.gsub("\r\n", "\n")
  File.open(file, 'w') { |f| f.puts updated_content }
end
