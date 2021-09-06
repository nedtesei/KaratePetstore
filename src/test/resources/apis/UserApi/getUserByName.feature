Feature: Get user by user name
	

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
    "username": "fill some value"
  },
  "body": null,
  "matchResponse": false,
  "responseMatch": {
    "id": "##number",
    "username": "##string",
    "firstName": "##string",
    "lastName": "##string",
    "email": "##string",
    "password": "##string",
    "phone": "##string",
    "userStatus": "##number"
  },
  "responseMatchesEach": {}
}
"""

@ignore @inline
Scenario: explore getUserByName inline
	You may use this test for quick API exploratorial purposes.
	* call read('getUserByName.feature@operation') inlineRequest

Scenario Outline: Test getUserByName for <status> status code
	* def req = read(<testDataFile>)
	* def result = call read('getUserByName.feature@operation') req
	* match result.responseStatus == <status>
		Examples:
		| status | testDataFile |
		| 200 | 'test-data/getUserByName_200.yml' |
		| 400 | 'test-data/getUserByName_400.yml' |
		| 404 | 'test-data/getUserByName_404.yml' |



@ignore @operation
Scenario: getUserByName
* def req = __arg
* def authHeader = call read('classpath:karate-auth.js') req.auth
* def headers = karate.merge(req.headers || {}, authHeader || {})
Given path '/user/', req.params.username
And headers headers
When method GET

* if (req.matchResponse === true) karate.call('getUserByName.feature@validate')

@ignore @validate
Scenario: validate getUserByName

* def expectedStatusCode = req.statusCode || responseStatus
* match responseStatus == expectedStatusCode

# match response schema in 'test-data' or any object
* def responseContains = req.matchResponse === true? req.responseMatch : responseType == 'json'? {} : ''
* match  response contains responseContains

