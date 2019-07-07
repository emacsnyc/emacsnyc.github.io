require "date"

class PostCreator
  MONDAY_INTEGER = 1

  def initialize(title:, layout:, body: nil)
    @title = title
    @layout = layout
    @body = body
  end

  def create
    if File.exist? path
      raise RuntimeError.new("Won't clobber #{path}")
    else
      File.open(path, "w") do |file|
        file.write content
      end
      puts "Created new post: #{filename}"
    end
  end

  private

  attr_reader :title, :layout, :body

  def path
    File.join("_posts", filename)
  end

  def filename
    "#{Time.now.strftime('%Y-%m-%d')}-#{fileized_title}.md"
  end

  def fileized_title
    title.
      gsub(/[\s.]/, "-").
      gsub(/:/, "").
      gsub(/&\w+;/, "-").
      downcase
  end

  def possible_scheduled_day
    initial_day = Date.new(2018, Date.today.next_month.month)
    initial_day + (initial_day.wday + MONDAY_INTEGER)
  end

  def content
    <<-EOS
---
layout: #{layout}
title: #{title}
date: #{Time.now.strftime('%Y-%m-%d %k:%M:%S')}
scheduled: #{possible_scheduled_day.strftime('%Y-%m-%d')} 18:30
---

#{body}
EOS
  end
end
