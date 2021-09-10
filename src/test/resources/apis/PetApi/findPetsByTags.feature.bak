Feature: Finds Pets by tags
	Multiple tags can be provided with comma separated strings. Use tag1, tag2, tag3 for testing.

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
    "tags": ""
  },
  "body": null,
  "matchResponse": false,
  "responseMatch": "##array",
  "responseMatchesEach": {}
}
"""

@ignore @inline
Scenario: explore findPetsByTags inline
	You may use this test for quick API exploratorial purposes.
	* call read('findPetsByTags.feature@operation') inlineRequest

Scenario Outline: Test findPetsByTags for <status> status code
	* def req = read(<testDataFile>)
	* def result = call read('findPetsByTags.feature@operation') req
	* match result.responseStatus == <status>
		Examples:
		| status | testDataFile |
		| 200 | 'test-data/findPetsByTags_200.yml' |
		| 400 | 'test-data/findPetsByTags_400.yml' |



@ignore @operation
Scenario: findPetsByTags
* def req = __arg
* def authHeader = call read('classpath:karate-auth.js') req.auth
* def headers = karate.merge(req.headers || {}, authHeader || {})
Given path '/pet/findByTags'
And param tags = req.params.tags
And headers headers
When method GET

* if (req.matchResponse === true) karate.call('findPetsByTags.feature@validate')

@ignore @validate
Scenario: validate findPetsByTags

* def expectedStatusCode = req.statusCode || responseStatus
* match responseStatus == expectedStatusCode

# match response schema in 'test-data' or any object
* def responseContains = req.matchResponse === true? req.responseMatch : responseType == 'json'? {} : ''
* match  each  response contains responseContains

