require "./spec_helper"

describe Maps::Base do
  it "creates a new Maps::Base" do
    world = Maps::Base.new(height: 25, width: 80)
    world.height.should eq 25
    world.width.should eq 80
    world.visible.should eq true
  end

  it "initializes the Text with the fill" do
    world = Maps::Base.new(height: 25, width: 80, fill: '#')
    world.text.size.should eq 25
    world.text[0].size.should eq 80
    world.text[0][0].should eq '#'
  end

  it "should support adding to parent" do
    world = Maps::Base.new(height: 25, width: 80)
    group = Maps::Base.new(height: 5, width: 5)
    group.add(parent: world, x: 10, y: 15)
    world.children[0].should eq group
    group.parent.should eq world
    group.x.should eq 10
    group.y.should eq 15
    group.z.should eq 1
  end

  it "should set new coordinates" do
    world = Maps::Base.new(height: 25, width: 80)
    group = Maps::Base.new(height: 5, width: 5)
    group.add(parent: world, x: 10, y: 15)
    group.set(x: 5, y: 5, z: 1)
    group.x.should eq 5
    group.y.should eq 5
    group.z.should eq 1
  end

  it "should suppport removing from parent" do
    world = Maps::Base.new(height: 25, width: 80)
    group = Maps::Base.new(height: 5, width: 0)
    group.add(parent: world, x: 10, y: 15)
    group.remove
    world.children.size.should eq 0
    group.parent.should eq nil
  end

  it "should be able to hide" do
    world = Maps::Base.new(height: 25, width: 80)
    world.visible = true
    world.hide
    world.visible.should eq false
  end

  it "should be able to show" do
    world = Maps::Base.new(height: 25, width: 80)
    world.visible = false
    world.show
    world.visible.should eq true
  end

  it "should render the text" do
    world = Maps::Base.new(height: 25, width: 80, fill: '#')
    screen = world.render
    screen[0][0].should eq '#'
    screen[24][79].should eq '#'
  end

  it "should render the children with the text" do
    world = Maps::Base.new(height: 25, width: 80, fill: '-')
    group = Maps::Base.new(height: 5, width: 5, fill: '#')
    group.add(parent: world, x: 10, y: 10)
    screen = world.render
    screen[0][0].should eq '-'
    screen[10][10].should eq '#'
    screen[14][14].should eq '#'
    screen[24][79].should eq '-'
  end

  it "should not render the child if hidden" do
    world = Maps::Base.new(height: 25, width: 80, fill: '-')
    group = Maps::Base.new(height: 5, width: 5, fill: '#')
    group.add(parent: world, x: 10, y: 10)
    group.hide
    screen = world.render
    screen[0][0].should eq '-'
    screen[10][10].should eq '-'
    screen[14][14].should eq '-'
    screen[24][79].should eq '-'
  end

  it "should renders by depth for siblings" do
    world = Maps::Base.new(height: 25, width: 80, fill: '-')
    group = Maps::Base.new(height: 5, width: 5, fill: '&')
    shadow = Maps::Base.new(height: 5, width: 5, fill: '#')
    group.add(parent: world, x: 10, y: 10, z: 2)
    shadow.add(parent: world, x: 11, y: 11)
    screen = world.render
    screen[0][0].should eq '-'
    screen[10][10].should eq '&'
    screen[14][14].should eq '&'
    screen[15][15].should eq '#'
    screen[24][79].should eq '-'
  end

  it "should bump if out of bounds if x < 0" do
    world = Maps::Base.new(height: 10, width: 10, fill: '-')
    group = Maps::Base.new(height: 5, width: 5, fill: '&')
    group.add(parent: world, x: -1, y: 0)
    group.obs.should eq true
  end
  it "should bump if out of bounds if x > height" do
    world = Maps::Base.new(height: 10, width: 10, fill: '-')
    group = Maps::Base.new(height: 5, width: 5, fill: '&')
    group.add(parent: world, x: 6, y: 0)
    group.add(world, 6, 0)
    group.obs.should eq true
  end

  it "should bump if out of bounds if y < 0" do
    world = Maps::Base.new(height: 10, width: 10, fill: '-')
    group = Maps::Base.new(height: 5, width: 5, fill: '&')
    group.add(parent: world, x: 0, y: -1)
    group.obs.should eq true
  end
  it "should bump if out of bounds if y > width" do
    world = Maps::Base.new(height: 10, width: 10, fill: '-')
    group = Maps::Base.new(height: 5, width: 5, fill: '&')
    group.add(parent: world, x: 0, y: 6)
    group.obs.should eq true
  end

  it "should not action if siblings do not collide" do
    world = Maps::Base.new(height: 10, width: 10, fill: '-')
    group1 = Maps::Base.new(height: 5, width: 5, fill: '&')
    group2 = Maps::Base.new(height: 5, width: 5, fill: '#')
    group1.add(parent: world, x: 0, y: 0)
    group2.add(parent: world, x: 5, y: 5)
    group1.collision.should eq false
    group2.collision.should eq false
  end

  it "should action if siblings collide" do
    world = Maps::Base.new(height: 10, width: 10, fill: '-')
    group1 = Maps::Base.new(height: 5, width: 5, fill: '&')
    group2 = Maps::Base.new(height: 5, width: 5, fill: '#')
    group1.add(parent: world, x: 4, y: 4)
    group2.add(parent: world, x: 4, y: 4)
    group1.collision.should eq true
    group2.collision.should eq true
  end

  it "should not action if siblings on different z axis" do
    world = Maps::Base.new(height: 10, width: 10, fill: '-')
    group1 = Maps::Base.new(height: 5, width: 5, fill: '&')
    group2 = Maps::Base.new(height: 5, width: 5, fill: '#')
    group1.add(parent: world, x: 4, y: 4, z: 1)
    group2.add(parent: world, x: 4, y: 4, z: 2)
    group1.collision.should eq false
    group2.collision.should eq false
    world.render
  end
end
