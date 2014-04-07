require 'spec_helper'

describe WrittenQuestionsController, "routes" do
  it "should map { :controller => 'written_questions', :action => 'index' } to /written_questions" do
    route_for(:controller => "written_questions", :action => "index").should == "/written_questions"
  end

  it "should map { :controller => 'written_questions', :action => 'show', :id => 1 } to /written_questions/1" do
    route_for(:controller => "written_questions", :action => "show", :id => 1).should == "/written_questions/1"
  end
end

describe WrittenQuestionsController, "handling GET /written_questions" do
  before do
    @questions = []
    WrittenQuestion.stub(:find).and_return(@questions)
  end

  it "should be successful" do
    get :index
    response.should be_success
  end

  it "should do an assign for questions" do
    get :index
    assigns[:questions].should eql(@questions)
  end

  it "should go to the index template" do
    get :index
    response.should render_template("index")
  end
end

describe WrittenQuestionsController, "handling GET /written_questions/1" do
  before do
    @question = mock_model(Question)
    WrittenQuestion.stub(:find).and_return(@question)
  end

  it "should be successful" do
    get :show, :id => 1
    response.should be_success
  end

  it "should assign to question" do
    get :show, :id => 1
    assigns[:question].should eql(@question)
  end

  it "should render the show template" do
    get :show, :id => 1
    response.should render_template("show")
  end
end
