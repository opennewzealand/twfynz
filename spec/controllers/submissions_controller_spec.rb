require 'spec_helper'

describe SubmissionsController, "handling GET /submissions" do

  before do
    @submission = mock_model(Submission)
    @submission.stub(:populate_submitter_id)
    Submission.stub(:find_by_sql).and_return([@submission])
    @controller.stub(:admin?).and_return(true)
  end

  it "should be successful" do
    get :index
    response.should be_success
  end

  it "should render index template" do
    get :index
    response.should render_template('index')
  end

  it "should assign the found submissions for the view" do
    get :index
    assigns[:submissions].should == [@submission]
  end
end

describe SubmissionsController, "handling GET /submissions/1" do

  before do
    @submission = mock_model(Submission)
    Submission.stub(:find).and_return(@submission)
    @controller.stub(:admin?).and_return(true)
  end

  it "should be successful" do
    get :show, id: 1
    response.should be_success
  end

  it "should render show template" do
    get :show, id: 1
    response.should render_template('show')
  end

  it "should find the submission requested" do
    Submission.should_receive(:find).with("1").and_return(@submission)
    get :show, id: 1
  end

  it "should assign the found submission for the view" do
    get :show, id: 1
    assigns[:submission].should equal(@submission)
  end
end

describe SubmissionsController, "handling GET /submissions/1.xml" do

  before do
    @submission = mock_model(Submission, :to_xml => "XML")
    Submission.stub(:find).and_return(@submission)
    @controller.stub(:admin?).and_return(true)
  end

  before :each do
    @request.env["HTTP_ACCEPT"] = "application/xml"
  end

  it "should be successful" do
    get :show, id: 1
    response.should be_success
  end

  it "should find the submission requested" do
    Submission.should_receive(:find).with("1").and_return(@submission)
    get :show, id: 1
  end

  it "should render the found submission as xml" do
    @submission.should_receive(:to_xml).and_return("XML")
    get :show, id: 1
    response.body.should == "XML"
  end
end

describe SubmissionsController, "handling GET /submissions/new" do

  before do
    @submission = mock_model(Submission)
    Submission.stub(:new).and_return(@submission)
    @controller.stub(:admin?).and_return(true)
  end

  it "should be successful" do
    get :new
    response.should be_success
  end

  it "should render new template" do
    get :new
    response.should render_template('new')
  end

  it "should create an new submission" do
    Submission.should_receive(:new).and_return(@submission)
    get :new
  end

  it "should not save the new submission" do
    @submission.should_not_receive(:save)
    get :new
  end

  it "should assign the new submission for the view" do
    get :new
    assigns[:submission].should equal(@submission)
  end
end

describe SubmissionsController, "handling GET /submissions/1/edit" do

  before do
    @submission = mock_model(Submission)
    Submission.stub(:find).and_return(@submission)
    @controller.stub(:admin?).and_return(true)
  end

  it "should be successful" do
    get :edit, id: 1
    response.should be_success
  end

  it "should render edit template" do
    get :edit, id: 1
    response.should render_template('edit')
  end

  it "should find the submission requested" do
    Submission.should_receive(:find).and_return(@submission)
    get :edit, id: 1
  end

  it "should assign the found Submission for the view" do
    get :edit, id: 1
    assigns[:submission].should equal(@submission)
  end
end

describe SubmissionsController, "handling POST /submissions" do

  before do
    @submission = mock_model(Submission, :to_param => "1", :save => true)
    Submission.stub(:new).and_return(@submission)
    @params = {}
    @controller.stub(:admin?).and_return(true)
  end

  it "should create a new submission" do
    Submission.should_receive(:new).with(@params).and_return(@submission)
    post :create, submission: @params
  end

  it "should redirect to the new submission" do
    post :create, submission: @params
    response.should redirect_to(submission_url("1"))
  end
end

describe SubmissionsController, "handling PUT /submissions/1" do

  before do
    @submission = mock_model(Submission, :to_param => "1", :update_attributes => true)
    @submission.stub(:reload)
    @submission.stub(:business_item_name).and_return ''
    @submission.stub(:evidence_url).and_return ''
    @submission.stub(:submitter_url).and_return ''
    @submission.stub(:submitter_name).and_return ''
    @submission.stub(:is_from_organisation).and_return(false)
    Submission.stub(:find).and_return(@submission)
    @controller.stub(:admin?).and_return(true)
  end

  it "should find the submission requested" do
    Submission.should_receive(:find).with("1").and_return(@submission)
    put :update, id: 1
  end

  it "should update the found submission" do
    @submission.should_receive(:update_attributes)
    put :update, id: 1
    assigns(:submission).should equal(@submission)
  end

  it "should assign the found submission for the view" do
    put :update, id: 1
    assigns(:submission).should equal(@submission)
  end

  it "should redirect to the submission" do
    put :update, id: 1
    response.should render_template('_submission')
  end
end
