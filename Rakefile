# frozen_string_literal: true

require "yaml"
require "./lib/post_creator"

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

desc "List all tags currently used."
task :tags do
  puts metadata.map { |md| md["tags"] }.flatten.compact.uniq.sort
end

MONTHLY_MEETUP = "Monthly Online Meetup".freeze

namespace :new do
  desc "Create a new generic announcement"
  task :announcement, [:title] do |_, args|
    PostCreator.new(title: args.title, layout: "announcement").create
  end

  desc "Create announcment for monthly meetup"
  task :monthly_meetup, [:title] do |_, args|
    PostCreator.new(
      title: [MONTHLY_MEETUP, args.title].join("&mdash;"),
      layout: "announcement",
    ).create
  end

  desc "Create announcment for monthly meetup"
  task :discussion, [:title] do |_, args|
    PostCreator.new(
      title: "Online Meetup&mdash;Discussion:#{args.title}",
      layout: "announcement",
    ).create
  end

  desc "Create announcment for monthly meetup specific to hack night"
  task :hack_night do
    PostCreator.new(
      title: [MONTHLY_MEETUP, "Hack Night"].join("&mdash;"),
      layout: "announcement",
      body: HACK_NIGHT,
    ).create
  end

  desc "Create announcment for monthly meetup specific to lightning talks"
  task :lightning_talks do
    PostCreator.new(
      title: [MONTHLY_MEETUP, "Lightning Talks"].join("&mdash;"),
      layout: "announcement",
      body: LIGHTNING_TALKS,
    ).create
  end

  desc "Create a new video post"
  task :video, [:title] do |_, args|
    PostCreator.new(title: args.title, layout: "video").create
  end
end

HACK_NIGHT = <<~BODY
  {% include time.html %}
  {% include location_online.html %}

  {% include hacknight.html %}
BODY

LIGHTNING_TALKS = <<~BODY
  {% include time.html %}
  {% include location_online.html %}

  {% include signup_lightning_talks.html %}
BODY
