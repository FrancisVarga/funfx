require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before do
    browser.goto(DEMO_APP)
    @flex = browser.flex_app('DemoAppId', 'DemoAppName')
    
    tree = @flex.tree({:id => 'objectTree'})
    tree.open('Date controls')
    tree.select('Date controls>DateField1')
  end
  
  it "should shift date" do
    date_field = @flex.date_field({:id => 'dateField1'})
    date_field.open
    date_field.change("May 8 2008")
    
    date_field.selected_date.should == Date.new(2008, 5, 8)
  end
  
  it "should shift month" do
    date_field = @flex.date_field({:id => 'dateField1'})
    date_field.open
    date_field.change("May 8 2008")
    
    date_field.open
    date_field.displayed_month.should == 4
    
    pending "Find out why it is not possible to scroll" do
      date_field.scroll("1")
      date_field.displayed_month.should == 3
      date_field.scroll("3")
      date_field.displayed_month.should == 4
    end
  end
end
