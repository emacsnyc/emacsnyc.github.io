class PostCreator
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
    end
  end

  private

  attr_reader :title, :layout

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

  def content
    <<-EOS
---
layout: #{layout}
title: #{title}
date: #{Time.now.strftime('%Y-%m-%d %k:%M:%S')}
---

#{body}
EOS
  end
end
