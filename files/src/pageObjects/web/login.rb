class Login

  def self.setupBrowser(browser)
    $method = __method__
    $browser = Watir::Browser.new :"#{browser}"
  end

  def self.navigate(url,waitObj)
    $method = __method__
    $browser.goto url
    $browser.text_field(:name => "#{waitObj}").wait_until_present
  end

  def self.login(username, password)
    $method = __method__
    $browser.text_field(:name => "username").set username
    $browser.text_field(:name => "password").set password
    $browser.input(:value => "Log in").click
    $browser.h1(:text => "Max Manager").wait_until_present
  end

end
