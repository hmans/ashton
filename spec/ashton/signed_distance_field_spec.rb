
require File.expand_path("../../helper.rb", __FILE__)


describe Ashton::SignedDistanceField do
  before :all do
    Gosu::enable_undocumented_retrofication

    $window ||= Gosu::Window.new 16, 16, false
    # ----------
    # -XXX------
    # -XXXX-----
    # -XXXX-----
    # ----------
    # ----------
    # ----------
    # ----------
    # ----------
    # ----------
    @image = Ashton::Framebuffer.new 10, 10
    @image.render do
      $window.pixel.draw 1, 1, 0, 3, 3
      $window.pixel.draw 4, 2, 0, 1, 2
    end

    @max_distance = 3
  end

  before :each do
    @subject = described_class.new @image, @max_distance
  end

  describe "initialize" do
    pending
  end

  describe "width" do
    it "should give the width of the original image" do
      @subject.height.should eq @image.width
    end
  end

  describe "height" do
    it "should give the height of the original image" do
      @subject.height.should eq @image.height
    end
  end

  describe "position_clear?" do
    it "should be true if there is room" do
      @subject.position_clear?(8, 4, 2).should be_true
    end

    it "should be false if there is no room" do
      @subject.position_clear?(8, 4, 4).should be_false
    end

    it "should be false inside a solid" do
      @subject.position_clear?(2, 2, 1).should be_false
    end
  end

  describe "sample_distance" do
    it "should give the appropriate distance" do
      @subject.sample_distance(1, 0).should eq 1
      @subject.sample_distance(7, 4).should eq 3
      @subject.sample_distance(1, 1).should eq 0
      @subject.sample_distance(2, 2).should eq -1
    end

    it "should max out at the specified limit" do
      @subject.sample_distance(9, 9).should eq @max_distance
    end
  end

  describe "line_of_sight?" do
    it "should be false if the sight line is blocked" do
      @subject.line_of_sight?(2, 0, 2, 9).should be_false
    end

    it "should be true if the sight line is uninterrupted" do
      @subject.line_of_sight?(0, 0, 0, 9).should be_true
    end
  end

  describe "line_of_sight_blocked_at" do
    it "should be false if the sight line is blocked" do
      @subject.line_of_sight_blocked_at(2, 0, 2, 9).should eq [2, 1]
    end

    it "should be nil if the sight line is uninterrupted" do
      @subject.line_of_sight_blocked_at(0, 0, 0, 9).should be_nil
    end
  end

  describe "sample_gradient" do
    it "should give expected values" do
      @subject.sample_gradient(1, 0).should eq [0, -1]
      @subject.sample_gradient(0, 1).should eq [-1, 0]

      @subject.sample_gradient(5, 3).should eq [2, 0]
      @subject.sample_gradient(1, 4).should eq [0, 2]
    end
  end

  describe "sample_normal" do
    it "should give expected values" do
      @subject.sample_normal(1, 0).should eq [0.0, -1.0]
      @subject.sample_normal(0, 1).should eq [-1.0, 0.0]

      @subject.sample_normal(5, 3).should eq [1.0, 0.0]
      @subject.sample_normal(1, 4).should eq [0.0, 1.0]
    end
  end

  describe "update_field" do
    pending
  end

  describe "draw" do
    pending
  end

  describe "to_a" do
    it "should generate the expected array" do
      # Remember this is rotated so array[x][y] works.
      @subject.to_a.should eq [
          [1, 1,  1, 1, 1, 2, 3, 3, 3, 3],
          [1, 0,  0, 0, 1, 2, 3, 3, 3, 3],
          [1, 0, -1, 0, 1, 2, 3, 3, 3, 3],
          [1, 0,  0, 0, 1, 2, 3, 3, 3, 3],
          [1, 1,  0, 0, 1, 2, 3, 3, 3, 3],
          [2, 1,  1, 1, 1, 2, 3, 3, 3, 3],
          [3, 2,  2, 2, 2, 3, 3, 3, 3, 3],
          [3, 3,  3, 3, 3, 3, 3, 3, 3, 3],
          [3, 3,  3, 3, 3, 3, 3, 3, 3, 3],
          [3, 3,  3, 3, 3, 3, 3, 3, 3, 3],
      ]
    end
  end
end