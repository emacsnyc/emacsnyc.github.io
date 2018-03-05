require 'yaml'
require './lib/post_creator'

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

namespace :new do
  desc "Create a new announcement"
  task :announcement, [:title] do |t, args|
    PostCreator.new(title: args.title, layout: "announcement").create
  end

  task :monthly_meetup, [:title] do |t, args|
    PostCreator.new(
      title: "Monthly Meetup&mdash;#{args.title}",
      layout: "announcement",
    ).create
  end

  task :hack_night do
    PostCreator.new(
      title: "Monthly Meetup&mdash;Hack Night",
      layout: "announcement",
      body: HACK_NIGHT,
    ).create
  end

  task :lightning_talks do
    PostCreator.new(
      title: "Monthly Meetup&mdash;Lightning Talks",
      layout: "announcement",
      body: LIGHTNING_TALKS,
    ).create
  end

  desc "Create a new video post"
  task :video, [:title] do |t, args|
    PostCreator.new(title: args.title, layout: "video").create
  end
end

HACK_NIGHT = <<-BODY
{% include time.html %}
{% include location_thoughtbot.html %}

{% include hacknight.html %}
BODY

LIGHTNING_TALKS = <<-BODY
{% include time.html %}
{% include location_thoughtbot.html %}

{% include lightning_talks.html %}
BODY
