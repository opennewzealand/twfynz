# encoding: UTF-8
require 'spec_helper'

describe WrittenQuestionParser do
  describe "answered questions" do

    before do
      @parser = WrittenQuestionParser.new
      @asker = Mp.new
      @respondent = Mp.new
      Mp.stub(:from_name).with("Clare Curran", Date.parse("2009-02-10")).and_return(@asker)
      Mp.stub(:from_name).with("Hon Steven Joyce", Date.parse("2009-02-10")).and_return(@respondent)
      @portfolio = Portfolio.new
      Portfolio.stub(:from_name).with("Communications and Information Technology").and_return(@portfolio)
      @result = @parser.parse(answered)
    end

    it "should have a parse method" do
      @parser.should respond_to :parse
    end

    it "should return a WrittenQuestion from calling parse" do
      @result.should_not be_nil
      @result.should be_an_instance_of WrittenQuestion
    end

    it "should parse out the question number" do
      @result.question_number.should eql(1)
    end

    it "should parse out the question year" do
      @result.question_year.should eql(2009)
    end

    it "should parse out the minister responsible" do
      @result.portfolio.should eql(@portfolio)
    end

    it "should parse out who's asking" do
      @result.asker.should eql(@asker)
    end

    it "should parse out question asked" do
      @result.question.should_not be_nil
      @result.question.should eql("What advice has the Minister sought or received in regards to deal with the implications of the current economic downturn for this portfolio?")
    end

    it "should parse out the date the question was asked" do
      @result.date_asked.should eql(Date.parse('2009-02-10'))
    end

    it "should parse out the subject correctly" do
      @result.subject.should eql("Communications")
    end

    it "should parse out the answer correctly" do
      @result.answer.should eql("The current economic downturn is relevant to all aspects of the Communications and Information Technology portfolio. All work, and hence all advice, in this area is aimed at responding to current economic challenges and driving up New Zealand’s long-term economic competitiveness. • the Ministry of Civil Defence and Emergency Management, comprising: o Civil Defence Emergency Management Development Unit; o Operations Unit; o Civil Defence Emergency Management Specialist Services Unit; and o Strategic Development and Business Support Unit. • the Civil Defence Emergency Management Policy Team, which is part of the Department of Internal Affairs’ Regulation and Compliance Branch; and • a communications team, which is part of the Department of Internal Affairs’ Strategic Communications Unit.")
    end

    it "should have a status of reply" do
      @result.status.should eql("reply")
    end

    it "should parse out the portfolio name correctly" do
      @result.portfolio_name.should eql("Minister for Communications and Information Technology")
    end

    it "should parse out the respondent correctly" do
      @result.respondent.should eql(@respondent)
    end
  end

  describe "unanswered question" do
    before do
      @parser = WrittenQuestionParser.new
      @asker = Mp.new
      Mp.stub(:from_name).with("Darien Fenton", Date.parse("2009-04-07")).and_return(@asker)
      @portfolio = Portfolio.new
      Portfolio.stub(:from_name).with("Transport").and_return(@portfolio)
      @result = @parser.parse(unanswered)
    end

    it "should have a status of question" do
      @result.status.should eql("question")
    end
  end

  describe "withdrawn question" do
    before do
      @result = @parser.parse(withdrawn)
    end
  end
end

def withdrawn
  <<HTML
    </HEAD>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html lang="en">
<head>
<title>New Zealand Parliament -     449 (2009). Question withdrawn.</title>

<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<link rel="icon" href="/favicon.ico" type="image/x-icon" />
<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
<link title="Parliament Library Search" type="application/opensearchdescription+xml" rel="search" href="http://www.parliament.nz/search.xml" />
<style type="text/css" media="screen,print">@import url(/CmsSystem/Css/Default.css);</style>

<link rel="stylesheet" type="text/css" href="/CmsSystem/Css/Print.css" media="print" />
<script type="text/javascript" src="/CmsSystem/Js/Rollovers.js"></script>
<script type="text/javascript" src="/CmsSystem/Js/Script.Aculo.Us/prototype.js"></script>






<meta name="keywords" content="parliament,house of representatives,government,nz,new zealand" />
<meta name="description" content="This is where our elected representatives make laws, debate important issues and keep a watch on government activity" />
<!-- Document Meta Data -->
<meta name="DC.Title" content="449 (2009). Question withdrawn." />
<meta name="DC.Date" content="2009-02-19T12:00:00.000Z" />
<meta name="DC.Creator" content="House Office (HoR)" />

<meta name="DC.Publisher" content="House Of Representatives" />
<meta name="DC.Subject" content="" />
<meta name="DC.Language" content="en-NZ" />
<meta name="DC.Format" content="Question - written" />
<meta name="DC.ChannelGuid" content="0cae94d4-4194-4266-84a4-28229a7e62a2" />
<meta name="NZGLS.Creator" content="House Office (HoR)" />

<meta name="NZGLS.Subject" content="" />
<meta name="NZGLS.Title" content="449 (2009). Question withdrawn." />
<meta name="NZGLS.Alternative" content="Question For Written Answer - 449 (2009)" />
<meta name="NZGLS.Type" content="Question - written" />
<meta name="NZGLS.Identifier" content="QWA_00449_2009" />
<meta name="NZGLS.Publisher" content="House Of Representatives" />
<meta name="NZGLS.Date" content="2009-02-19T12:00:00.000Z" />
<meta name="NZGLS.Language" content="en-NZ" />
<meta name="NZGLS.Format" content="text/html" />
<!-- /Document Meta Data -->


<script type="text/javascript" src="/CmsSystem/Js/Script.Aculo.Us/prototype.js"></script>

<!--[if lte IE 6]>
<style type="text/css" media="screen,print">@import url(/CmsSystem/Css/IE6.css);</style>
<![endif]-->

</head>

<body id="top">



<div class="hide"><a href="#content" accesskey="[">Skip to main content</a></div>
<div class="hide"><a href="#nav">Skip to navigation</a></div>
<div class="hide"><a href="#AccessKeys" accesskey="0">List of access keys</a></div>


<div id="master">
	<!-- header -->
	<div id="header">
		<a href="/en-NZ/" accesskey="1"><img src="/CmsSystem/Images/Logo.gif" width="75" height="82" alt="New Zealand House of Representatives" border="0" /></a>
		<h1>New Zealand Parliament</h1>
		<div class="inSitting"><a href=/en-NZ/ThisWk/Programme/></a></div>
		<!-- search -->
		<form id="searchForm" action="/en-NZ/Search/" method="get">

		<div class="search">
			<input name="q" type="text" id="Search" alt="Enter search term(s)" value="Search " class="searchBox" onfocus="this.style.backgroundColor='#FFF';this.style.color='#000';if(this.value=='Search '){this.value=''};" /><input type="submit" value="Go" title="Submit search" class="submitButton" />
			<!-- <a href="#"><img src="Images/Intranet/AdvancedSearch.gif" width="106" height="19" alt="View Advanced Search Options" /></a> -->
			<span class="advancedSearch"><a href="/en-NZ/Search/?SearchByForm=true" accesskey="3">Advanced Search </a></span>
		</div>
		</form>
		<!-- /search -->

	</div>

	<!-- /header -->

	<!-- breadcrumb trail and sidelinks -->
	<div class="headerLinks">
		<ul>
			<li><li class='notLive'><a href='/en-NZ/Visiting/LiveBroadcast/'>Broadcasting </a></li></li>
			<!--<li><a href="/en-NZ/Register.htm">Register for updates</a></li>-->
		</ul>
		<ul>

			<li><a id="ctl00_ctl00_Header_ctl00_hypAlerts" href="/en-NZ/Alerts/">Alerts</a></li>
		</ul>
		<div class="breadCrumb">
			<a href="/en-NZ/">Home </a> &gt; <a href="/en-NZ/PB/">Parliamentary business</a> &gt; <a href="/en-NZ/PB/Debates/">Order Paper, Debates (Hansard), Questions, Daily progress, Journals</a> &gt; <a href="/en-NZ/PB/Debates/QWA/">Questions for written answer</a>

			<!--a href="/">Home</a> &gt; <a href="#">Parliamentary Business</a> &gt; Decisions, Questions &amp; Debates-->
		</div>
	</div>
	<!-- /breadcrumb trail and sidelinks -->

	<hr />

	<!-- main body -->
	<div id="mainContent">

		<!-- navigation -->
		<div class="nav" id="nav">

			<dl id="ctl00_ctl00_Header_ctl00_ctl03">
	<dt>Public Menu</dt><dd><a href="/en-NZ/HowPWorks/">How Parliament works</a></dd><dd class="selected"><a href="/en-NZ/PB/">Parliamentary business</a><dl>
		<dd><a href="/en-NZ/PB/Legislation/">Bills, SOPs, Acts, Regulations</a></dd><dd class="selected"><a href="/en-NZ/PB/Debates/">Order Paper, Debates (Hansard), Questions, Daily progress, Journals</a><dl>
			<dd class="noSub"><a href="/en-NZ/PB/Debates/OrderPaper/">Order Paper</a></dd><dd class="noSub"><a href="/en-NZ/PB/Debates/Progress/">Daily progress in the House</a></dd><dd class="selected noSub"><a href="/en-NZ/PB/Debates/QWA/">Questions for written answer</a></dd><dd class="noSub"><a href="/en-NZ/PB/Debates/Journals/">Journals of the House</a></dd><dd class="noSub"><a href="/en-NZ/PB/Debates/QOA/">Questions for oral answer</a></dd><dd><a href="/en-NZ/PB/Debates/Debates/">Debates (Hansard)</a></dd>

		</dl></dd><dd><a href="/en-NZ/PB/Presented/">Select committee reports, Papers, Petitions</a></dd><dd><a href="/en-NZ/PB/Reference/">Standing Orders, Speakers' Rulings, Sessional orders</a></dd>
	</dl></dd><dd><a href="/en-NZ/SC/">Select committees</a></dd><dd><a href="/en-NZ/MPP/">MPs and parties</a></dd><dd><a href="/en-NZ/ThisWk/">This week</a></dd><dd><a href="/en-NZ/PubRes/">Publications and research</a></dd><dd><a href="/en-NZ/HvYrSay/">Have your say</a></dd><dd><a href="/en-NZ/Visiting/">Visiting</a></dd><dd><a href="/en-NZ/HstBldgs/">History and buildings</a></dd><dd><a href="/en-NZ/Education/">Education</a></dd><dd class="noSub"><a href="/en-NZ/Explore/">Explore Parliament</a></dd><dd><a href="/en-NZ/Admin/">Administration</a></dd><dd><a href="/en-NZ/Alerts/">Alerts</a></dd>

</dl>



					<dl class="languages">
					<dt>Languages </dt>

					<dd class="selected"><a href="/en-NZ/PB/Debates/QWA/5/7/6/QWA_00449_2009-449-2009-Question-withdrawn.htm" title="English version of the site - Currently Selected">English</a></dd>

					<dd><a href="/mi-NZ/PB/Debates/QWA/2/4/a/QWA_00449_2009-449-2009-Question-withdrawn.htm" title="Māori version of the site">Māori </a></dd>

					</dl>


		</div>


<form name="aspnetForm" method="post"  id="aspnetForm" action="/en-NZ/PB/Debates/QWA/5/7/6/QWA_00449_2009-449-2009-Question-withdrawn.htm">
<div>
<input type="hidden" name="__VIEWSTATE" id="__VIEWSTATE" value="/wEPDwULLTE1NjIzMjU0MjJkZDXjRNw2GoXkEmhQPnKwD3YIyhfG" />
</div>


<script language="javascript" type="text/javascript">
<!--
   var __CMS_PostbackForm = document.forms['aspnetForm'];
   var __CMS_CurrentUrl = "/CmsSystem/Templates/Documents/Bill.aspx?NRMODE=Published&NRORIGINALURL=%2fen-NZ%2fPB%2fDebates%2fQWA%2f5%2f7%2f6%2fQWA_00449_2009-449-2009-Question-withdrawn%2ehtm&NRNODEGUID=%7bCCC1EEC9-6E79-4A92-B478-A0CF4D390B21%7d&NRCACHEHINT=NoModifyGuest";
// -->
</script>



<!--[if IE]><input type="text" style="width: 1px; height: 1px; display: none;" disabled="disabled" size="1" /><!-->

<div id="content">

<!-- main content -->
<div class="contentBody">



		<!-- section header -->

		<div class="sectionHeader withSubHeader">
			<h1>Order Paper, Debates (Hansard), Questions, Daily progress, Journals</h1>
			<h2>Questions for written answer</h2>
		</div>


		<!-- /section header -->





		<!-- related links -->
		<div class="infoTiles right">

			<table border="0" cellspacing="0" cellpadding="0" width="195">

			<!-- content provider -->
			<tbody id="ctl00_ctl00_MainContent_ctl02_tbContentProvider">
			<tr>
				<th>
					<div class="hdr">Content Provider</div>

				</th>
			</tr>
			<tr>
				<td class="contentProvider">
					<img id="ctl00_ctl00_MainContent_ctl02_imgContentProviderLogo" src="/NR/rdonlyres/59C64988-A9C6-4DF2-9710-2DEF7AC70796/0/HouseofRepresentatives.jpg" alt="House Of Representatives" style="border-width:0px;" />

					<!--<img src="/CmsSystem/Images/Example/ContentProvider.gif" width="195" height="102" alt="House of Representitives" border="0" />-->
					<!-- House of Representitives -->
				</td>
			</tr>

			</tbody>
			<!-- /content provider -->

			<!-- image -->
			<tbody>
			<tr>
				<td class="image">
					<span></span>

				</td>
			</tr>

			</tbody>
			<!-- /image -->

			<!-- information -->
			<tbody>
			<tr>
				<th>
					<div class="hdr">Information</div>
				</th>

			</tr>
			<tr>
				<td class="information">
					<dl>
						<dt>Date:</dt>
						<dd>19 February 2009</dd>

					</dl>

					<div class="divider"><!--  --></div>




				</td>
			</tr>
			<!-- /information -->






			<!-- document to sibling document link -->








			<!-- sibling document to current document link-->







			<!-- display medialinks when doctype is hansards -->

			<!-- display linkdocument when doctype is not hansards -->













			</tbody>
			</table>

		</div>
		<!-- /related links -->

		<div class="copy">
			<div class="section">
    <h1></h1>
    <div class="qandaset">

        <div class="question">
          <span class="label">449 (2009)</span>


            <strong>Question Withdrawn</strong>

        </div>

    </div>
  </div>
		</div>








</div>

</div>
<br class="clear" />

</form>

</div>


<hr />

	<!-- footer links -->
	<div class="footerLinks">
		<a href="#top" class="top">Top </a>
		<ul>
			<li><a accesskey="2" href="/en-NZ/Sitemap/">Sitemap </a></li>

			<!--<li><a href="/en-NZ/Glossary/">Glossary </a></li>-->
			<li><a accesskey="9" href="/en-NZ/Contact/">Contact us</a></li>
			<li><a href="http://www.newzealand.govt.nz/" accesskey="/">newzealand.govt.nz</a></li>
			<li><a href="/en-NZ/Accessibility/">Accessibility </a></li>
		</ul>

		<div>
			<a id="ctl00_ctl00_ctl01_Localizedchannelitemhyperlink1" NAME="Localizedchannelitemhyperlink1" href="/en-NZ/FAQs/">FAQ</a>

		</div>


		<br class="clear" />
	</div>
	<!-- /footer links -->

	<!-- access keys -->
	<div id="AccessKeys" class="hide">
		Use your access keys with your browser:
		<dl title="Access Keys">
			<dt>0</dt><dd>List of access keys</dd>

			<dt>1</dt><dd>Home</dd>
			<dt>2</dt><dd>Sitemap</dd>
			<dt>3</dt><dd>Search</dd>
			<dt>9</dt><dd>Contact Us</dd>
			<dt>[</dt><dd>Beginning of main document</dd>

			<dt>/</dt><dd>Go to http://www.govt.nz</dd>
		</dl>
	</div>
	<!-- /access keys -->






</div>

</body>

</html>
HTML
end

def unanswered
  <<HTML
  </HEAD>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en">
<head>
<title>New Zealand Parliament -     3218 (2009). Darien Fenton to the Minister of Transport</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<link rel="icon" href="/favicon.ico" type="image/x-icon" />
<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
<link title="Parliament Library Search" type="application/opensearchdescription+xml" rel="search" href="http://www.parliament.nz/search.xml" />
<style type="text/css" media="screen,print">@import url(/CmsSystem/Css/Default.css);</style>
<link rel="stylesheet" type="text/css" href="/CmsSystem/Css/Print.css" media="print" />
<script type="text/javascript" src="/CmsSystem/Js/Rollovers.js"></script>
<script type="text/javascript" src="/CmsSystem/Js/Script.Aculo.Us/prototype.js"></script>

<meta name="keywords" content="parliament,house of representatives,government,nz,new zealand" />
<meta name="description" content="This is where our elected representatives make laws, debate important issues and keep a watch on government activity" />
<!-- Document Meta Data -->
<meta name="DC.Title" content="3218 (2009). Darien Fenton to the Minister of Transport" />
<meta name="DC.Date" content="2009-04-07T12:00:00.000Z" />
<meta name="DC.Creator" content="House Office (HoR)" />
<meta name="DC.Publisher" content="House Of Representatives" />
<meta name="DC.Subject" content="Transport" />
<meta name="DC.Language" content="en-NZ" />
<meta name="DC.Format" content="Question - written" />
<meta name="DC.ChannelGuid" content="0cae94d4-4194-4266-84a4-28229a7e62a2" />
<meta name="NZGLS.Creator" content="House Office (HoR)" />
<meta name="NZGLS.Subject" content="Transport" />
<meta name="NZGLS.Title" content="3218 (2009). Darien Fenton to the Minister of Transport" />
<meta name="NZGLS.Alternative" content="Question For Written Answer - 3218 (2009)" />
<meta name="NZGLS.Type" content="Question - written" />
<meta name="NZGLS.Identifier" content="QWA_03218_2009" />

<meta name="NZGLS.Publisher" content="House Of Representatives" />
<meta name="NZGLS.Date" content="2009-04-07T12:00:00.000Z" />
<meta name="NZGLS.Language" content="en-NZ" />
<meta name="NZGLS.Format" content="text/html" />
<!-- /Document Meta Data -->
<script type="text/javascript" src="/CmsSystem/Js/Script.Aculo.Us/prototype.js"></script>
<!--[if lte IE 6]>
<style type="text/css" media="screen,print">@import url(/CmsSystem/Css/IE6.css);</style>
<![endif]-->
</head>
<body id="top">
<div class="hide"><a href="#content" accesskey="[">Skip to main content</a></div>
<div class="hide"><a href="#nav">Skip to navigation</a></div>
<div class="hide"><a href="#AccessKeys" accesskey="0">List of access keys</a></div>
<div id="master">

	<!-- header -->
	<div id="header">
		<a href="/en-NZ/" accesskey="1"><img src="/CmsSystem/Images/Logo.gif" width="75" height="82" alt="New Zealand House of Representatives" border="0" /></a>
		<h1>New Zealand Parliament</h1>
		<div class="inSitting"><a href=/en-NZ/ThisWk/Programme/></a></div>
		<!-- search -->
		<form id="searchForm" action="/en-NZ/Search/" method="get">
		<div class="search">

			<input name="q" type="text" id="Search" alt="Enter search term(s)" value="Search " class="searchBox" onfocus="this.style.backgroundColor='#FFF';this.style.color='#000';if(this.value=='Search '){this.value=''};" /><input type="submit" value="Go" title="Submit search" class="submitButton" />
			<!-- <a href="#"><img src="Images/Intranet/AdvancedSearch.gif" width="106" height="19" alt="View Advanced Search Options" /></a> -->
			<span class="advancedSearch"><a href="/en-NZ/Search/?SearchByForm=true" accesskey="3">Advanced Search </a></span>
		</div>
		</form>
		<!-- /search -->
	</div>
	<!-- /header -->

	<!-- breadcrumb trail and sidelinks -->
	<div class="headerLinks">
		<ul>
			<li><li class='notLive'><a href='/en-NZ/Visiting/LiveBroadcast/'>Broadcasting </a></li></li>
			<!--<li><a href="/en-NZ/Register.htm">Register for updates</a></li>-->
		</ul>
		<ul>
			<li><a id="ctl00_ctl00_Header_ctl00_hypAlerts" href="/en-NZ/Alerts/">Alerts</a></li>

		</ul>
		<div class="breadCrumb">
			<a href="/en-NZ/">Home </a> &gt; <a href="/en-NZ/PB/">Parliamentary business</a> &gt; <a href="/en-NZ/PB/Debates/">Order Paper, Debates (Hansard), Questions, Daily progress, Journals</a> &gt; <a href="/en-NZ/PB/Debates/QWA/">Questions for written answer</a>
			<!--a href="/">Home</a> &gt; <a href="#">Parliamentary Business</a> &gt; Decisions, Questions &amp; Debates-->

		</div>
	</div>
	<!-- /breadcrumb trail and sidelinks -->
	<hr />
	<!-- main body -->
	<div id="mainContent">
		<!-- navigation -->
		<div class="nav" id="nav">
			<dl id="ctl00_ctl00_Header_ctl00_ctl03">

	<dt>Public Menu</dt><dd><a href="/en-NZ/HowPWorks/">How Parliament works</a></dd><dd class="selected"><a href="/en-NZ/PB/">Parliamentary business</a><dl>
		<dd><a href="/en-NZ/PB/Legislation/">Bills, SOPs, Acts, Regulations</a></dd><dd class="selected"><a href="/en-NZ/PB/Debates/">Order Paper, Debates (Hansard), Questions, Daily progress, Journals</a><dl>
			<dd class="noSub"><a href="/en-NZ/PB/Debates/OrderPaper/">Order Paper</a></dd><dd class="noSub"><a href="/en-NZ/PB/Debates/Progress/">Daily progress in the House</a></dd><dd class="selected noSub"><a href="/en-NZ/PB/Debates/QWA/">Questions for written answer</a></dd><dd class="noSub"><a href="/en-NZ/PB/Debates/Journals/">Journals of the House</a></dd><dd class="noSub"><a href="/en-NZ/PB/Debates/QOA/">Questions for oral answer</a></dd><dd><a href="/en-NZ/PB/Debates/Debates/">Debates (Hansard)</a></dd>

		</dl></dd><dd><a href="/en-NZ/PB/Presented/">Select committee reports, Papers, Petitions</a></dd><dd><a href="/en-NZ/PB/Reference/">Standing Orders, Speakers' Rulings, Sessional orders</a></dd>
	</dl></dd><dd><a href="/en-NZ/SC/">Select committees</a></dd><dd><a href="/en-NZ/MPP/">MPs and parties</a></dd><dd><a href="/en-NZ/ThisWk/">This week</a></dd><dd><a href="/en-NZ/PubRes/">Publications and research</a></dd><dd><a href="/en-NZ/HvYrSay/">Have your say</a></dd><dd><a href="/en-NZ/Visiting/">Visiting</a></dd><dd><a href="/en-NZ/HstBldgs/">History and buildings</a></dd><dd><a href="/en-NZ/Education/">Education</a></dd><dd class="noSub"><a href="/en-NZ/Explore/">Explore Parliament</a></dd><dd><a href="/en-NZ/Admin/">Administration</a></dd><dd><a href="/en-NZ/Alerts/">Alerts</a></dd>

</dl>
					<dl class="languages">
					<dt>Languages </dt>
					<dd class="selected"><a href="/en-NZ/PB/Debates/QWA/d/9/9/QWA_03218_2009-3218-2009-Darien-Fenton-to-the-Minister-of-Transport.htm" title="English version of the site - Currently Selected">English</a></dd>
					<dd><a href="/mi-NZ/PB/Debates/QWA/a/9/9/QWA_03218_2009-3218-2009-Darien-Fenton-to-the-Minister-of-Transport.htm" title="Māori version of the site">Māori </a></dd>
					</dl>
		</div>
<form name="aspnetForm" method="post"  id="aspnetForm" action="/en-NZ/PB/Debates/QWA/d/9/9/QWA_03218_2009-3218-2009-Darien-Fenton-to-the-Minister-of-Transport.htm">

<input type="hidden" name="__VIEWSTATE" id="__VIEWSTATE" value="/wEPDwULLTE1NjIzMjU0MjJkZDXjRNw2GoXkEmhQPnKwD3YIyhfG" />
<script language="javascript" type="text/javascript">
<!--
   var __CMS_PostbackForm = document.forms['aspnetForm'];
   var __CMS_CurrentUrl = "/CmsSystem/Templates/Documents/Bill.aspx?NRMODE=Published&NRORIGINALURL=%2fen-NZ%2fPB%2fDebates%2fQWA%2fd%2f9%2f9%2fQWA_03218_2009-3218-2009-Darien-Fenton-to-the-Minister-of-Transport%2ehtm&NRNODEGUID=%7bEBC41A61-4A6B-410D-9506-96FB5739AE4C%7d&NRCACHEHINT=NoModifyGuest";
// -->
</script>
<!--[if IE]><input type="text" style="width: 1px; height: 1px; display: none;" disabled="disabled" size="1" /><!-->
<div id="content">
<!-- main content -->
<div class="contentBody">
		<!-- section header -->
		<div class="sectionHeader withSubHeader">
			<h1>Order Paper, Debates (Hansard), Questions, Daily progress, Journals</h1>
			<h2>Questions for written answer</h2>

		</div>
		<!-- /section header -->
		<!-- related links -->
		<div class="infoTiles right">
			<table border="0" cellspacing="0" cellpadding="0" width="195">
			<!-- content provider -->
			<tbody id="ctl00_ctl00_MainContent_ctl02_tbContentProvider">
			<tr>
				<th>

					<div class="hdr">Content Provider</div>
				</th>
			</tr>
			<tr>
				<td class="contentProvider">
					<img id="ctl00_ctl00_MainContent_ctl02_imgContentProviderLogo" src="/NR/rdonlyres/59C64988-A9C6-4DF2-9710-2DEF7AC70796/0/HouseofRepresentatives.jpg" alt="House Of Representatives" border="0" />
					<!--<img src="/CmsSystem/Images/Example/ContentProvider.gif" width="195" height="102" alt="House of Representitives" border="0" />-->
					<!-- House of Representitives -->

				</td>
			</tr>
			</tbody>
			<!-- /content provider -->
			<!-- image -->
			<tbody>
			<tr>
				<td class="image">
					<span></span>

				</td>
			</tr>
			</tbody>
			<!-- /image -->
			<!-- information -->
			<tbody>
			<tr>
				<th>
					<div class="hdr">Information</div>

				</th>
			</tr>
			<tr>
				<td class="information">
					<dl>
						<dt>Date:</dt>
						<dd>7 April 2009</dd>
						<dt>Subject</dt>

						<dd><a rel="nofollow" href="/en-NZ/Search/?s=Transport">Transport</a></dd>
					</dl>
					<div class="divider"><!--  --></div>
				</td>
			</tr>
			<!-- /information -->
			<!-- document to sibling document link -->
			<!-- sibling document to current document link-->

			<!-- display medialinks when doctype is hansards -->
			<!-- display linkdocument when doctype is not hansards -->
			</tbody>
			</table>
		</div>
		<!-- /related links -->
		<div class="copy">
			<div class="section">
    <h1></h1>

    <div class="qandaset">
        <div class="question">
          <span class="label">3218 (2009). </span>
            <span class="personname Member">
              Darien
              Fenton
            </span> to the <strong>Minister of Transport</strong> (07 Apr 2009):
What funding, programme advice and resources does the Land Transport Safety Authority provide to assist in minimising the problem of paediatric driveway vehicle accidents?
        </div>

        <div class="answer">
            <span class="personname Minister">
              Hon
              Steven
              Joyce
            </span> (Minister of Transport) replied: Reply due: 17 Apr 2009
        </div>
    </div>
  </div>
		</div>
</div>
</div>

<br class="clear" />
</form>
</div>
<hr />
	<!-- footer links -->
	<div class="footerLinks">
		<a href="#top" class="top">Top </a>
		<ul>
			<li><a accesskey="2" href="/en-NZ/Sitemap/">Sitemap </a></li>
			<!--<li><a href="/en-NZ/Glossary/">Glossary </a></li>-->

			<li><a accesskey="9" href="/en-NZ/Contact/">Contact us</a></li>
			<li><a href="http://www.newzealand.govt.nz/" accesskey="/">newzealand.govt.nz</a></li>
			<li><a href="/en-NZ/Accessibility/">Accessibility </a></li>
		</ul>
		<div>
			<a id="ctl00_ctl00_ctl01_Localizedchannelitemhyperlink1" NAME="Localizedchannelitemhyperlink1" href="/en-NZ/FAQs/">FAQ</a>
		</div>

		<br class="clear" />
	</div>
	<!-- /footer links -->
	<!-- access keys -->
	<div id="AccessKeys" class="hide">
		Use your access keys with your browser:
		<dl title="Access Keys">
			<dt>0</dt><dd>List of access keys</dd>

			<dt>1</dt><dd>Home</dd>
			<dt>2</dt><dd>Sitemap</dd>
			<dt>3</dt><dd>Search</dd>
			<dt>9</dt><dd>Contact Us</dd>
			<dt>[</dt><dd>Beginning of main document</dd>

			<dt>/</dt><dd>Go to http://www.govt.nz</dd>
		</dl>
	</div>
	<!-- /access keys -->
</div>
</body>
</html>
HTML
end

def answered
  <<HTML
  </HEAD>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html lang="en">
<head>
<title>New Zealand Parliament -     1 (2009). Clare Curran to the Minister for Communications and Information Technology</title>

<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<link rel="icon" href="/favicon.ico" type="image/x-icon" />
<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
<link title="Parliament Library Search" type="application/opensearchdescription+xml" rel="search" href="http://www.parliament.nz/search.xml" />
<style type="text/css" media="screen,print">@import url(/CmsSystem/Css/Default.css);</style>

<link rel="stylesheet" type="text/css" href="/CmsSystem/Css/Print.css" media="print" />
<script type="text/javascript" src="/CmsSystem/Js/Rollovers.js"></script>
<script type="text/javascript" src="/CmsSystem/Js/Script.Aculo.Us/prototype.js"></script>






<meta name="keywords" content="parliament,house of representatives,government,nz,new zealand" />
<meta name="description" content="This is where our elected representatives make laws, debate important issues and keep a watch on government activity" />
<!-- Document Meta Data -->
<meta name="DC.Title" content="1 (2009). Clare Curran to the Minister for Communications and Information Technology" />
<meta name="DC.Date" content="2009-02-10T12:00:00.000Z" />
<meta name="DC.Creator" content="House Office (HoR)" />

<meta name="DC.Publisher" content="House Of Representatives" />
<meta name="DC.Subject" content="Communications" />
<meta name="DC.Language" content="en-NZ" />
<meta name="DC.Format" content="Question - written" />
<meta name="DC.ChannelGuid" content="0cae94d4-4194-4266-84a4-28229a7e62a2" />
<meta name="NZGLS.Creator" content="House Office (HoR)" />

<meta name="NZGLS.Subject" content="Communications" />
<meta name="NZGLS.Title" content="1 (2009). Clare Curran to the Minister for Communications and Information Technology" />
<meta name="NZGLS.Alternative" content="Question For Written Answer - 1 (2009)" />
<meta name="NZGLS.Type" content="Question - written" />
<meta name="NZGLS.Identifier" content="QWA_00001_2009" />
<meta name="NZGLS.Publisher" content="House Of Representatives" />
<meta name="NZGLS.Date" content="2009-02-10T12:00:00.000Z" />
<meta name="NZGLS.Language" content="en-NZ" />
<meta name="NZGLS.Format" content="text/html" />
<!-- /Document Meta Data -->


<script type="text/javascript" src="/CmsSystem/Js/Script.Aculo.Us/prototype.js"></script>

<!--[if lte IE 6]>
<style type="text/css" media="screen,print">@import url(/CmsSystem/Css/IE6.css);</style>
<![endif]-->

</head>

<body id="top">



<div class="hide"><a href="#content" accesskey="[">Skip to main content</a></div>
<div class="hide"><a href="#nav">Skip to navigation</a></div>
<div class="hide"><a href="#AccessKeys" accesskey="0">List of access keys</a></div>


<div id="master">
	<!-- header -->
	<div id="header">
		<a href="/en-NZ/" accesskey="1"><img src="/CmsSystem/Images/Logo.gif" width="75" height="82" alt="New Zealand House of Representatives" border="0" /></a>
		<h1>New Zealand Parliament</h1>
		<div class="inSitting"><a href=/en-NZ/ThisWk/Programme/>The House is sitting today</a></div>
		<!-- search -->
		<form id="searchForm" action="/en-NZ/Search/" method="get">

		<div class="search">
			<input name="q" type="text" id="Search" alt="Enter search term(s)" value="Search " class="searchBox" onfocus="this.style.backgroundColor='#FFF';this.style.color='#000';if(this.value=='Search '){this.value=''};" /><input type="submit" value="Go" title="Submit search" class="submitButton" />
			<!-- <a href="#"><img src="Images/Intranet/AdvancedSearch.gif" width="106" height="19" alt="View Advanced Search Options" /></a> -->
			<span class="advancedSearch"><a href="/en-NZ/Search/?SearchByForm=true" accesskey="3">Advanced Search </a></span>
		</div>
		</form>
		<!-- /search -->

	</div>

	<!-- /header -->

	<!-- breadcrumb trail and sidelinks -->
	<div class="headerLinks">
		<ul>
			<li><li class='notLive'><a href='/en-NZ/Visiting/LiveBroadcast/'>Broadcasting </a></li></li>
			<!--<li><a href="/en-NZ/Register.htm">Register for updates</a></li>-->
		</ul>
		<ul>

			<li><a id="ctl00_ctl00_Header_ctl00_hypAlerts" href="/en-NZ/Alerts/">Alerts</a></li>
		</ul>
		<div class="breadCrumb">
			<a href="/en-NZ/">Home </a> &gt; <a href="/en-NZ/PB/">Parliamentary business</a> &gt; <a href="/en-NZ/PB/Debates/">Order Paper, Debates (Hansard), Questions, Daily progress, Journals</a> &gt; <a href="/en-NZ/PB/Debates/QWA/">Questions for written answer</a>

			<!--a href="/">Home</a> &gt; <a href="#">Parliamentary Business</a> &gt; Decisions, Questions &amp; Debates-->
		</div>
	</div>
	<!-- /breadcrumb trail and sidelinks -->

	<hr />

	<!-- main body -->
	<div id="mainContent">

		<!-- navigation -->
		<div class="nav" id="nav">

			<dl id="ctl00_ctl00_Header_ctl00_ctl03">
	<dt>Public Menu</dt><dd><a href="/en-NZ/HowPWorks/">How Parliament works</a></dd><dd class="selected"><a href="/en-NZ/PB/">Parliamentary business</a><dl>
		<dd><a href="/en-NZ/PB/Legislation/">Bills, SOPs, Acts, Regulations</a></dd><dd class="selected"><a href="/en-NZ/PB/Debates/">Order Paper, Debates (Hansard), Questions, Daily progress, Journals</a><dl>
			<dd class="noSub"><a href="/en-NZ/PB/Debates/OrderPaper/">Order Paper</a></dd><dd class="noSub"><a href="/en-NZ/PB/Debates/Progress/">Daily progress in the House</a></dd><dd class="selected noSub"><a href="/en-NZ/PB/Debates/QWA/">Questions for written answer</a></dd><dd class="noSub"><a href="/en-NZ/PB/Debates/Journals/">Journals of the House</a></dd><dd class="noSub"><a href="/en-NZ/PB/Debates/QOA/">Questions for oral answer</a></dd><dd><a href="/en-NZ/PB/Debates/Debates/">Debates (Hansard)</a></dd>

		</dl></dd><dd><a href="/en-NZ/PB/Presented/">Select committee reports, Papers, Petitions</a></dd><dd><a href="/en-NZ/PB/Reference/">Standing Orders, Speakers' Rulings, Sessional orders</a></dd>
	</dl></dd><dd><a href="/en-NZ/SC/">Select committees</a></dd><dd><a href="/en-NZ/MPP/">MPs and parties</a></dd><dd><a href="/en-NZ/ThisWk/">This week</a></dd><dd><a href="/en-NZ/PubRes/">Publications and research</a></dd><dd><a href="/en-NZ/HvYrSay/">Have your say</a></dd><dd><a href="/en-NZ/Visiting/">Visiting</a></dd><dd><a href="/en-NZ/HstBldgs/">History and buildings</a></dd><dd><a href="/en-NZ/Education/">Education</a></dd><dd class="noSub"><a href="/en-NZ/Explore/">Explore Parliament</a></dd><dd><a href="/en-NZ/Admin/">Administration</a></dd><dd><a href="/en-NZ/Alerts/">Alerts</a></dd>

</dl>



					<dl class="languages">
					<dt>Languages </dt>

					<dd class="selected"><a href="/en-NZ/PB/Debates/QWA/3/c/b/QWA_00001_2009-1-2009-Clare-Curran-to-the-Minister-for-Communications.htm" title="English version of the site - Currently Selected">English</a></dd>

					<dd><a href="/mi-NZ/PB/Debates/QWA/1/8/f/QWA_00001_2009-1-2009-Clare-Curran-to-the-Minister-for-Communications.htm" title="Māori version of the site">Māori </a></dd>

					</dl>


		</div>


<form name="aspnetForm" method="post"  id="aspnetForm" action="/en-NZ/PB/Debates/QWA/3/c/b/QWA_00001_2009-1-2009-Clare-Curran-to-the-Minister-for-Communications.htm">
<div>
<input type="hidden" name="__VIEWSTATE" id="__VIEWSTATE" value="/wEPDwULLTE1NjIzMjU0MjJkZDXjRNw2GoXkEmhQPnKwD3YIyhfG" />
</div>


<script language="javascript" type="text/javascript">
<!--
   var __CMS_PostbackForm = document.forms['aspnetForm'];
   var __CMS_CurrentUrl = "/CmsSystem/Templates/Documents/Bill.aspx?NRMODE=Published&NRORIGINALURL=%2fen-NZ%2fPB%2fDebates%2fQWA%2f3%2fc%2fb%2fQWA_00001_2009-1-2009-Clare-Curran-to-the-Minister-for-Communications%2ehtm&NRNODEGUID=%7b99BE9530-BCEF-4186-BC6C-41306E60D8B3%7d&NRCACHEHINT=NoModifyGuest";
// -->
</script>



<!--[if IE]><input type="text" style="width: 1px; height: 1px; display: none;" disabled="disabled" size="1" /><!-->

<div id="content">

<!-- main content -->
<div class="contentBody">



		<!-- section header -->

		<div class="sectionHeader withSubHeader">
			<h1>Order Paper, Debates (Hansard), Questions, Daily progress, Journals</h1>
			<h2>Questions for written answer</h2>
		</div>


		<!-- /section header -->





		<!-- related links -->
		<div class="infoTiles right">

			<table border="0" cellspacing="0" cellpadding="0" width="195">

			<!-- content provider -->
			<tbody id="ctl00_ctl00_MainContent_ctl02_tbContentProvider">
			<tr>
				<th>
					<div class="hdr">Content Provider</div>

				</th>
			</tr>
			<tr>
				<td class="contentProvider">
					<img id="ctl00_ctl00_MainContent_ctl02_imgContentProviderLogo" src="/NR/rdonlyres/59C64988-A9C6-4DF2-9710-2DEF7AC70796/0/HouseofRepresentatives.jpg" alt="House Of Representatives" style="border-width:0px;" />

					<!--<img src="/CmsSystem/Images/Example/ContentProvider.gif" width="195" height="102" alt="House of Representitives" border="0" />-->
					<!-- House of Representitives -->
				</td>
			</tr>

			</tbody>
			<!-- /content provider -->

			<!-- image -->
			<tbody>
			<tr>
				<td class="image">
					<span></span>

				</td>
			</tr>

			</tbody>
			<!-- /image -->

			<!-- information -->
			<tbody>
			<tr>
				<th>
					<div class="hdr">Information</div>
				</th>

			</tr>
			<tr>
				<td class="information">
					<dl>
						<dt>Date:</dt>
						<dd>10 February 2009</dd>

						<dt>Subject</dt>

						<dd><a rel="nofollow" href="/en-NZ/Search/?s=Communications">Communications</a></dd>

					</dl>

					<div class="divider"><!--  --></div>



				</td>
			</tr>
			<!-- /information -->






			<!-- document to sibling document link -->








			<!-- sibling document to current document link-->








			<!-- display medialinks when doctype is hansards -->

			<!-- display linkdocument when doctype is not hansards -->













			</tbody>
			</table>
		</div>
		<!-- /related links -->

		<div class="copy">
			<div class="section">
    <h1></h1>

    <div class="qandaset">

        <div class="question">
          <span class="label">1 (2009). </span>

            <span class="personname Member">

              Clare
              Curran
            </span> to the <strong>Minister for Communications and Information Technology</strong> (10 Feb 2009): What advice has the Minister sought or received in regards to deal with the implications of the current economic downturn for this portfolio?
        </div>

        <div class="answer">

            <span class="personname Minister">
              Hon
              Steven
              Joyce
            </span> (Minister for Communications and Information Technology) replied: The current economic downturn is relevant to all aspects of the Communications and Information Technology portfolio.  All work, and hence all advice, in this area is aimed at responding to current economic challenges and driving up New Zealand’s long-term economic competitiveness.
• the Ministry of Civil Defence and Emergency Management, comprising:
o Civil Defence Emergency Management Development Unit;
o Operations Unit;
o Civil Defence Emergency Management Specialist Services Unit; and
o Strategic Development and Business Support Unit.
• the Civil Defence Emergency Management Policy Team, which is part of the Department of Internal Affairs’ Regulation and Compliance Branch; and
• a communications team, which is part of the Department of Internal Affairs’ Strategic Communications Unit.

        </div>

    </div>
  </div>
		</div>









</div>

</div>
<br class="clear" />

</form>

</div>


<hr />

	<!-- footer links -->
	<div class="footerLinks">
		<a href="#top" class="top">Top </a>

		<ul>
			<li><a accesskey="2" href="/en-NZ/Sitemap/">Sitemap </a></li>
			<!--<li><a href="/en-NZ/Glossary/">Glossary </a></li>-->
			<li><a accesskey="9" href="/en-NZ/Contact/">Contact us</a></li>
			<li><a href="http://www.newzealand.govt.nz/" accesskey="/">newzealand.govt.nz</a></li>
			<li><a href="/en-NZ/Accessibility/">Accessibility </a></li>
		</ul>

		<div>
			<a id="ctl00_ctl00_ctl01_Localizedchannelitemhyperlink1" NAME="Localizedchannelitemhyperlink1" href="/en-NZ/FAQs/">FAQ</a>
		</div>


		<br class="clear" />
	</div>
	<!-- /footer links -->

	<!-- access keys -->
	<div id="AccessKeys" class="hide">

		Use your access keys with your browser:
		<dl title="Access Keys">
			<dt>0</dt><dd>List of access keys</dd>
			<dt>1</dt><dd>Home</dd>
			<dt>2</dt><dd>Sitemap</dd>
			<dt>3</dt><dd>Search</dd>

			<dt>9</dt><dd>Contact Us</dd>
			<dt>[</dt><dd>Beginning of main document</dd>
			<dt>/</dt><dd>Go to http://www.govt.nz</dd>
		</dl>
	</div>
	<!-- /access keys -->






</div>

</body>

</html>
HTML
end
