Feature: Deletes a pet
	

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
    "api_key": "fill some value",
    "petId": 0
  },
  "body": null,
  "matchResponse": false,
  "responseMatch": null,
  "responseMatchesEach": {}
}
"""

@ignore @inline
Scenario: explore deletePet inline
	You may use this test for quick API exploratorial purposes.
	* call read('deletePet.feature@operation') inlineRequest

Scenario Outline: Test deletePet for <status> status code
	* def req = read(<testDataFile>)
	* def result = call read('deletePet.feature@operation') req
	* match result.responseStatus == <status>
		Examples:
		| status | testDataFile |
		| 400 | 'test-data/deletePet_400.yml' |



@ignore @operation
Scenario: deletePet
* def req = __arg
* def authHeader = call read('classpath:karate-auth.js') req.auth
* def headers = karate.merge(req.headers || {}, authHeader || {})
Given path '/pet/', req.params.petId
And headers headers
When method DELETE

* if (req.matchResponse === true) karate.call('deletePet.feature@validate')

@ignore @validate
Scenario: validate deletePet

* def expectedStatusCode = req.statusCode || responseStatus
* match responseStatus == expectedStatusCode
