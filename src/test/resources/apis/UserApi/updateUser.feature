Feature: Update user
	This can only be done by the logged in user.

Background:
* url baseUrl
# You may read this inlineRequest as request/response documentation o use it for quick exploratory testing
* def inlineRequest =
"""
{
  "auth": null,
  "statusCode": null,
  "headers": {},
  "params": {
    "username": "fill some value"
  },
  "body": {
    "id": 10,
    "username": "theUser",
    "firstName": "John",
    "lastName": "James",
    "email": "john@email.com",
    "password": "12345",
    "phone": "12345",
    "userStatus": 1
  },
  "matchResponse": false,
  "responseMatch": null,
  "responseMatchesEach": {}
}
"""

@ignore @inline
Scenario: explore updateUser inline
	You may use this test for quick API exploratorial purposes.
	* call read('updateUser.feature@operation') inlineRequest

Scenario Outline: Test updateUser for <status> status code
	* def req = read(<testDataFile>)
	* def result = call read('updateUser.feature@operation') req
	* match result.responseStatus == <status>
		Examples:
		| status | testDataFile |
		| default | 'test-data/updateUser_default.yml' |



@ignore @operation
Scenario: updateUser
* def req = __arg
* def authHeader = call read('classpath:karate-auth.js') req.auth
* def headers = karate.merge(req.headers || {}, authHeader || {})
Given path '/user/', req.params.username
And headers headers
And request req.body
When method PUT

* if (req.matchResponse === true) karate.call('updateUser.feature@validate')

@ignore @validate
Scenario: validate updateUser

* def expectedStatusCode = req.statusCode || responseStatus
* match responseStatus == expectedStatusCode
