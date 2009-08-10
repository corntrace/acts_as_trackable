require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/../lib/acts_as_trackable')

describe "ActAsTrackable" do

  before(:all) do
    load_schema
  end

  before(:each) do
    @order = Order.create(:name => "test order", :desc => 'desc ...')
    @track = Track.create(:content => 'test track', :operator_name => 'Kevin')
  end

  it "should be include in the ActiveRecord::Base class" do
    ActiveRecord::Base.respond_to?(:acts_as_trackable).should == true
  end

  it "should respond to class methods in the trackable object(Order)" do
    @order.add_track @track
    Order.find_tracks_for(@order).include?(@track).should == true
    Order.respond_to?(:find_comments_by_operator).should == true
  end

  it "should respond to object methods in the trackable object(Order)" do
    @order.add_track @track
    @order.tracks_ordered_by_submitted.length.should == 1
  end

  it "should add track by tow methods" do
    @order.add_track :content => "Test content", :operator_name => "Test name"
    track = Track.create(:content => "Another Test Content", :operator_name => "Test name 2")
    @order.add_track track
    @order.tracks.length.should == 2
  end

  it "should add a track by default operator_name System" do
    @order.add_track :content => "Test content"
    @order.tracks.length.should == 1
    @order.tracks.first.operator_name.should == 'System'
  end

end
