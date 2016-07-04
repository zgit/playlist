class GroupId

  def self.apiLogin(url, options = {})
      $method = __method__
        endPoint = '/j_spring_security_check'
        method = 'post'
        body = { 'j_username' => options['apiUsername'], 'j_password' => options['apiPassword'] }
        resLogin = Api.apiRequest(url, endPoint, method, body)
        Api.resCodeValidation(resLogin, 200)
        puts resLogin.body
        puts resLogin.cookies
    return resLogin
  end

  def self.apiCreateGroup(url, options = {})
    $method = __method__
      endPoint = '/api/group'
      method = 'post'
      body = {group: {groupName: "zApis"}}
      puts body
      resGroupId = Api.apiRequest(url, endPoint, method, body)
      Api.resCodeValidation(resGroupId, 200)
    return resGroupId
  end

  def self.apiGroupId(url, options = {})
    $method = __method__
      endPoint = '/api/group/0'
      method = 'get'
      resGroupId = Api.apiRequest(url, endPoint, method, nil)
      Api.resCodeValidation(resGroupId, 200)
    return resGroupId
  end

end
