Login.setupBrowser($config['browser'])
Login.navigate($config['url'], $test_data['waitObj'])
Login.login($test_data['managerUsername'], $test_data['password'])
Logout.logout($test_data['waitObj'])
Logout.tearDown
