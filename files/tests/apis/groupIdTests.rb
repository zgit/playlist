
url = $config['url']
apiUsername = $config['username']
apiPassword = $config['password']

resLogin = GroupId.apiLogin(url, { "apiUsername" => apiUsername , "apiPassword" => apiPassword })
$cookies = resLogin.cookies
resCreate = GroupId.apiCreateGroup(url)
puts resCreate
res = GroupId.apiGroupId(url)
puts res
