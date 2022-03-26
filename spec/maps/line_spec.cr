require "./spec_helper"

describe Maps::Line do
  it "creates a 45 deg Line Map" do
    world = Maps::Line.new(width: 10, height: 10, fill: '+')
    world.render.each do |row|
      puts row.join
    end
  end

  it "creates a 30 deg Line Map" do
    world = Maps::Line.new(width: 20, height: 10, fill: '+')
    world.render.each do |row|
      puts row.join
    end
  end

  it "creates a 60 deg Line Map" do
    world = Maps::Line.new(width: 10, height: 20, fill: '+')
    world.render.each do |row|
      puts row.join
    end
  end

  it "creates a vertical Line Map" do
    world = Maps::Line.new(width: 10, height: 1, fill: '+')
    world.render.each do |row|
      puts row.join
    end
  end

  it "creates a horizontal Line Map" do
    world = Maps::Line.new(width: 1, height: 10, fill: '+')
    world.render.each do |row|
      puts row.join
    end
  end

  it "creates an inverted 45 deg Line Map" do
    world = Maps::Line.new(width: 10, height: 10, inverted: true, fill: '+')
    world.render.each do |row|
      puts row.join
    end
  end

  it "creates a 30 deg Line Map" do
    world = Maps::Line.new(width: 20, height: 10, inverted: true, fill: '+')
    world.render.each do |row|
      puts row.join
    end
  end

  it "creates a 60 deg Line Map" do
    world = Maps::Line.new(width: 10, height: 20, inverted: true, fill: '+')
    world.render.each do |row|
      puts row.join
    end
  end
end
