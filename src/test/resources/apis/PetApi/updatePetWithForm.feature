Feature: Updates a pet in the store with form data
	

Background:
* url baseUrl
# You may read this inlineRequest as request/response documentation o use it for quick exploratory testing
* def inlineRequest =
"""
{
  "auth": null,
  "statusCode": 405,
  "headers": {},
  "params": {
    "petId": 0,
    "name": "fill some value",
    "status": "fill some value"
  },
  "body": null,
  "matchResponse": false,
  "responseMatch": null,
  "responseMatchesEach": {}
}
"""

@ignore @inline
Scenario: explore updatePetWithForm inline
	You may use this test for quick API exploratorial purposes.
	* call read('updatePetWithForm.feature@operation') inlineRequest

Scenario Outline: Test updatePetWithForm for <status> status code
	* def req = read(<testDataFile>)
	* def result = call read('updatePetWithForm.feature@operation') req
	* match result.responseStatus == <status>
		Examples:
		| status | testDataFile |
		| 405 | 'test-data/updatePetWithForm_405.yml' |



@ignore @operation
Scenario: updatePetWithForm
* def req = __arg
* def authHeader = call read('classpath:karate-auth.js') req.auth
* def headers = karate.merge(req.headers || {}, authHeader || {})
Given path '/pet/', req.params.petId
And param name = req.params.name
And param status = req.params.status
And headers headers
When method POST

* if (req.matchResponse === true) karate.call('updatePetWithForm.feature@validate')

@ignore @validate
Scenario: validate updatePetWithForm

* def expectedStatusCode = req.statusCode || responseStatus
* match responseStatus == expectedStatusCode
