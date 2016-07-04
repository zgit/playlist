class Logout

  def self.logout(waitObj)
    $method = __method__
    sleep 4
    $browser.img(:alt => "Picture of Max Manager").click
    $browser.ul(:id => "action-menu-0-menu").span(:text => "Log out").click
    $browser.text_field(:name => "#{waitObj}").wait_until_present
  end

  def self.tearDown
    $method = __method__
    if (($browser.nil?) == false) then
        $browser.quit
    end
  end

end
