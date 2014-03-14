require 'yaml'

task default: :new

def ask(message)
  print message
  STDIN.gets.chomp
end

def post_metadata(post_path)
  if File.exists?(post_path)
    File.open(post_path, 'r') do |file|
      lines = file.readlines
      i, j, _ = lines.each_with_index.find_all { |line, i| line =~ /---/ }.map { |_, i| i }
      header = lines[i + 1...j].join
      YAML.load(header)
    end
  end
end

def metadata
  FileList.new('_posts/*.md').map { |f| post_metadata(f) }
end

####################

desc 'List all tags currently used.'
task :tags do
  puts metadata.map { |md| md['tags'] }.flatten.compact.uniq.sort
end
