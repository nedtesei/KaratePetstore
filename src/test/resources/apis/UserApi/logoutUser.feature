Feature: Logs out current logged in user session
	

Background:
* url baseUrl
# You may read this inlineRequest as request/response documentation o use it for quick exploratory testing
* def inlineRequest =
"""
{
  "auth": null,
  "statusCode": null,
  "headers": {},
  "params": {},
  "body": null,
  "matchResponse": false,
  "responseMatch": null,
  "responseMatchesEach": {}
}
"""

@ignore @inline
Scenario: explore logoutUser inline
	You may use this test for quick API exploratorial purposes.
	* call read('logoutUser.feature@operation') inlineRequest

Scenario Outline: Test logoutUser for <status> status code
	* def req = read(<testDataFile>)
	* def result = call read('logoutUser.feature@operation') req
	* match result.responseStatus == <status>
		Examples:
		| status | testDataFile |
		| default | 'test-data/logoutUser_default.yml' |



@ignore @operation
Scenario: logoutUser
* def req = __arg
* def authHeader = call read('classpath:karate-auth.js') req.auth
* def headers = karate.merge(req.headers || {}, authHeader || {})
Given path '/user/logout'
And headers headers
When method GET

* if (req.matchResponse === true) karate.call('logoutUser.feature@validate')

@ignore @validate
Scenario: validate logoutUser

* def expectedStatusCode = req.statusCode || responseStatus
* match responseStatus == expectedStatusCode
