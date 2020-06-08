require "date"

class PostCreator
  MONDAY_INTEGER = 1
  DAYS_IN_WEEK = 7

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
    first_day_of_following_month +
      (DAYS_IN_WEEK - first_day_of_following_month.wday + MONDAY_INTEGER) %
      DAYS_IN_WEEK
  end

  def first_day_of_following_month
    Date.new(today.year, today.next_month.month)
  end

  def today
    Date.today
  end

  def content
    <<-EOS
---
layout: #{layout}
title: #{title}
date: #{Time.now.strftime('%Y-%m-%d %k:%M:%S')}
scheduled: #{possible_scheduled_day.strftime('%Y-%m-%d')} 19:00
signup_form_url: <<fill in sign in form url if necessary>>
---

#{body}
EOS
  end
end
