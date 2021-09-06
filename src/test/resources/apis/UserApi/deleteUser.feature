Feature: Delete user
	This can only be done by the logged in user.

Background:
* url baseUrl
# You may read this inlineRequest as request/response documentation o use it for quick exploratory testing
* def inlineRequest =
"""
{
  "auth": null,
  "statusCode": 400,
  "headers": {},
  "params": {
    "username": "fill some value"
  },
  "body": null,
  "matchResponse": false,
  "responseMatch": null,
  "responseMatchesEach": {}
}
"""

@ignore @inline
Scenario: explore deleteUser inline
	You may use this test for quick API exploratorial purposes.
	* call read('deleteUser.feature@operation') inlineRequest

Scenario Outline: Test deleteUser for <status> status code
	* def req = read(<testDataFile>)
	* def result = call read('deleteUser.feature@operation') req
	* match result.responseStatus == <status>
		Examples:
		| status | testDataFile |
		| 400 | 'test-data/deleteUser_400.yml' |
		| 404 | 'test-data/deleteUser_404.yml' |



@ignore @operation
Scenario: deleteUser
* def req = __arg
* def authHeader = call read('classpath:karate-auth.js') req.auth
* def headers = karate.merge(req.headers || {}, authHeader || {})
Given path '/user/', req.params.username
And headers headers
When method DELETE

* if (req.matchResponse === true) karate.call('deleteUser.feature@validate')

@ignore @validate
Scenario: validate deleteUser

* def expectedStatusCode = req.statusCode || responseStatus
* match responseStatus == expectedStatusCode
