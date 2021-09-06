Feature: Finds Pets by status
	Multiple status values can be provided with comma separated strings

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
    "status": "available"
  },
  "body": null,
  "matchResponse": false,
  "responseMatch": "##array",
  "responseMatchesEach": {}
}
"""

@ignore @inline
Scenario: explore findPetsByStatus inline
	You may use this test for quick API exploratorial purposes.
	* call read('findPetsByStatus.feature@operation') inlineRequest

Scenario Outline: Test findPetsByStatus for <status> status code
	* def req = read(<testDataFile>)
	* def result = call read('findPetsByStatus.feature@operation') req
	* match result.responseStatus == <status>
		Examples:
		| status | testDataFile |
		| 200 | 'test-data/findPetsByStatus_200.yml' |
		| 400 | 'test-data/findPetsByStatus_400.yml' |



@ignore @operation
Scenario: findPetsByStatus
* def req = __arg
* def authHeader = call read('classpath:karate-auth.js') req.auth
* def headers = karate.merge(req.headers || {}, authHeader || {})
Given path '/pet/findByStatus'
And param status = req.params.status
And headers headers
When method GET

* if (req.matchResponse === true) karate.call('findPetsByStatus.feature@validate')

@ignore @validate
Scenario: validate findPetsByStatus

* def expectedStatusCode = req.statusCode || responseStatus
* match responseStatus == expectedStatusCode

# match response schema in 'test-data' or any object
* def responseContains = req.matchResponse === true? req.responseMatch : responseType == 'json'? {} : ''
* match  each  response contains responseContains

