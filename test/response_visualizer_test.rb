require 'test/unit'
require 'fileutils'

require 'rubygems'
require 'mocha'

RAILS_ROOT = '.'
require 'response_visualizer'

class ResponseVisualizerTest < Test::Unit::TestCase
  
  # class Response
  #   attr_accessor :body
  # end
  # 
  # def test_foo
  #   response = Response.new
  #   response.body = "<html>FOO</html>"
  #   @response = response
  #   vr(:html)
  # end
  
  def setup
    @response = stub(:body => "<html></html>")
  end
  
  def test_visualize_response
    self.expects(:create_tmp_if_missing)
    File.expects(:open).with(RESPONSE_HTML, File::CREAT|File::TRUNC|File::WRONLY)
    Browser.expects(:open).with("http://localhost:3000/tmp/response.html")
    visualize_response
  end
  
  def test_visualize_response_in_web
    self.expects(:create_tmp_if_missing)
    File.expects(:open).with(RESPONSE_HTML, File::CREAT|File::TRUNC|File::WRONLY)
    Browser.expects(:open).with("http://localhost:3000/tmp/response.html")
    visualize_response(:web)
  end
  
  def test_visualize_response_in_html
    self.expects(:create_tmp_if_missing)
    File.expects(:open).with(RESPONSE_TXT, File::CREAT|File::TRUNC|File::WRONLY)
    Browser.expects(:open).with("./public/tmp/response.txt")
    visualize_response(:html)
  end
  
  def test_visualize_response_with_raw_html
    self.expects(:create_tmp_if_missing)
    File.expects(:open).with(RESPONSE_HTML, File::CREAT|File::TRUNC|File::WRONLY)
    Browser.expects(:open).with("./public/tmp/response.html")
    visualize_response("<html></html>")
  end
  
  def test_create_tmp_if_missing_when_tmp_does_not_exist
    File.expects(:exists?).with(TMP).returns(false)
    FileUtils.expects(:mkdir_p).with(TMP)
    self.expects(:`).with("which svn").returns("/opt/local/bin/svn")
    self.expects(:`).with("svn propset svn:ignore tmp ./public")
    create_tmp_if_missing
  end
  
  def test_create_tmp_if_missing_when_tmp_already_exists
    File.expects(:exists?).with(TMP).returns(true)
    FileUtils.expects(:mkdir).never
    create_tmp_if_missing
  end
  
  def test_create_tmp_if_missing_when_svn_is_not_available
    # TODO: write me
  end
  
end
