Feature: Logs user into the system
	

Background:
* url baseUrl
# You may read this inlineRequest as request/response documentation o use it for quick exploratory testing
* def inlineRequest =
"""
{
  "auth": null,
  "statusCode": 200,
  "headers": {},
  "params": {
    "username": "fill some value",
    "password": "fill some value"
  },
  "body": null,
  "matchResponse": false,
  "responseMatch": "##string",
  "responseMatchesEach": {}
}
"""

@ignore @inline
Scenario: explore loginUser inline
	You may use this test for quick API exploratorial purposes.
	* call read('loginUser.feature@operation') inlineRequest

Scenario Outline: Test loginUser for <status> status code
	* def req = read(<testDataFile>)
	* def result = call read('loginUser.feature@operation') req
	* match result.responseStatus == <status>
		Examples:
		| status | testDataFile |
		| 200 | 'test-data/loginUser_200.yml' |
		| 400 | 'test-data/loginUser_400.yml' |



@ignore @operation
Scenario: loginUser
* def req = __arg
* def authHeader = call read('classpath:karate-auth.js') req.auth
* def headers = karate.merge(req.headers || {}, authHeader || {})
Given path '/user/login'
And param username = req.params.username
And param password = req.params.password
And headers headers
When method GET

* if (req.matchResponse === true) karate.call('loginUser.feature@validate')

@ignore @validate
Scenario: validate loginUser

* def expectedStatusCode = req.statusCode || responseStatus
* match responseStatus == expectedStatusCode

# match response schema in 'test-data' or any object
* def responseContains = req.matchResponse === true? req.responseMatch : responseType == 'json'? {} : ''
* match  response contains responseContains

