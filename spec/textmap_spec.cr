require "./spec_helper"

describe TextMap do
  it "creates a new TextMap" do
    world = TextMap.new(height: 25, width: 80)
    world.height.should eq 25
    world.width.should eq 80
    world.visible.should eq true
  end

  it "initializes the Text with the fill" do
    world = TextMap.new(height: 25, width: 80, fill: '#')
    world.text.size.should eq 25
    world.text[0].size.should eq 80
    world.text[0][0].should eq '#'
  end

  it "should support adding to parent" do
    world = TextMap.new(height: 25, width: 80)
    group = TextMap.new(height: 5, width: 5)
    group.add(world, 10, 15)
    world.children[0].should eq group
    group.parent.should eq world
    group.x.should eq 10
    group.y.should eq 15
    group.z.should eq 1
  end

  it "should set new coordinates" do
    world = TextMap.new(height: 25, width: 80)
    group = TextMap.new(height: 5, width: 5)
    group.add(world, 10, 15)
    group.set(5, 5, 1)
    group.x.should eq 5
    group.y.should eq 5
    group.z.should eq 1
  end

  it "should suppport removing from parent" do
    world = TextMap.new(height: 25, width: 80)
    group = TextMap.new(height: 5, width: 0)
    group.add(world, 10, 15)
    group.remove
    world.children.size.should eq 0
    group.parent.should eq nil
  end

  it "should be able to hide" do
    world = TextMap.new(height: 25, width: 80)
    world.visible = true
    world.hide
    world.visible.should eq false
  end

  it "should be able to show" do
    world = TextMap.new(height: 25, width: 80)
    world.visible = false
    world.show
    world.visible.should eq true
  end

  it "should render the text" do
    world = TextMap.new(height: 25, width: 80, fill: '#')
    screen = world.render
    screen[0][0].should eq '#'
    screen[24][79].should eq '#'
  end

  it "should render the children with the text" do
    world = TextMap.new(height: 25, width: 80, fill: '-')
    group = TextMap.new(height: 5, width: 5, fill: '#')
    group.add(world, 10, 10)
    screen = world.render
    screen[0][0].should eq '-'
    screen[10][10].should eq '#'
    screen[14][14].should eq '#'
    screen[24][79].should eq '-'
  end

  it "should not render the child if hidden" do
    world = TextMap.new(height: 25, width: 80, fill: '-')
    group = TextMap.new(height: 5, width: 5, fill: '#')
    group.add(world, 10, 10)
    group.hide
    screen = world.render
    screen[0][0].should eq '-'
    screen[10][10].should eq '-'
    screen[14][14].should eq '-'
    screen[24][79].should eq '-'
  end

  it "should renders by depth for siblings" do
    world = TextMap.new(height: 25, width: 80, fill: '-')
    group = TextMap.new(height: 5, width: 5, fill: '&')
    shadow = TextMap.new(height: 5, width: 5, fill: '#')
    group.add(world, 10, 10, 2)
    shadow.add(world, 11, 11)
    screen = world.render
    screen[0][0].should eq '-'
    screen[10][10].should eq '&'
    screen[14][14].should eq '&'
    screen[15][15].should eq '#'
    screen[24][79].should eq '-'
  end

  it "should bump if out of bounds if x < 0" do
    world = TextMap.new(height: 10, width: 10, fill: '-')
    group = TextMap.new(height: 5, width: 5, fill: '&')
    group.add(world, -1, 0)
    group.obs.should eq true
  end
  it "should bump if out of bounds if x > height" do
    world = TextMap.new(height: 10, width: 10, fill: '-')
    group = TextMap.new(height: 5, width: 5, fill: '&')
    group.add(world, 5, 0)
    group.obs.should eq true
  end

  it "should bump if out of bounds if y < 0" do
    world = TextMap.new(height: 10, width: 10, fill: '-')
    group = TextMap.new(height: 5, width: 5, fill: '&')
    group.add(world, 0, -1)
    group.obs.should eq true
  end
  it "should bump if out of bounds if y > width" do
    world = TextMap.new(height: 10, width: 10, fill: '-')
    group = TextMap.new(height: 5, width: 5, fill: '&')
    group.add(world, 0, 5)
    group.obs.should eq true
  end

  it "should not action if siblings do not collide" do
    world = TextMap.new(height: 10, width: 10, fill: '-')
    group1 = TextMap.new(height: 5, width: 5, fill: '&')
    group2 = TextMap.new(height: 5, width: 5, fill: '#')
    group1.add(world, 0, 0)
    group2.add(world, 5, 5)
    group1.collision.should eq false
    group2.collision.should eq false
  end

  it "should action if siblings collide" do
    world = TextMap.new(height: 10, width: 10, fill: '-')
    group1 = TextMap.new(height: 5, width: 5, fill: '&')
    group2 = TextMap.new(height: 5, width: 5, fill: '#')
    group1.add(world, 0, 0)
    group2.add(world, 4, 4)
    group1.collision.should eq true
    group2.collision.should eq true
  end

  it "should not action if siblings on different z axis" do
    world = TextMap.new(height: 10, width: 10, fill: '-')
    group1 = TextMap.new(height: 5, width: 5, fill: '&')
    group2 = TextMap.new(height: 5, width: 5, fill: '#')
    group1.add(world, 0, 0)
    group2.add(world, 4, 4, 2)
    group1.collision.should eq false
    group2.collision.should eq false
    world.render
  end
end
