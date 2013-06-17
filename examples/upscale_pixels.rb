#!/usr/bin/env ruby
require 'bundler/setup'
Bundler.require

def media_path(file); File.expand_path "media/#{file}", File.dirname(__FILE__) end

class Window < Gosu::Window
  def initialize(*args)
    super
    @hmans = Gosu::Image.new(self, media_path("hmans.jpg"), true)
    @texture = Ashton::Texture.new 800, 600
    @rot = 0.0
  end

  def update
    @rot += 2.0
  end

  def draw
    @texture.render do
      @hmans.draw_rot 100, 75, 1, @rot, 0.5, 0.5, 0.5, 0.5
    end

    scale 4 do
      @texture.draw 0, 0, 0
    end
  end

  def button_down(id)
    case id
    when Gosu::KbEscape
      close
    end
  end
end

Gosu.enable_undocumented_retrofication
Window.new(800, 600, false).show
