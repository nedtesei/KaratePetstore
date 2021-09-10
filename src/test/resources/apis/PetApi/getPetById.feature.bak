Feature: Find pet by ID
	Returns a single pet

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
    "petId": 0
  },
  "body": null,
  "matchResponse": false,
  "responseMatch": {
    "id": "##number",
    "name": "#string",
    "category": {
      "id": "##number",
      "name": "##string"
    },
    "photoUrls": "#array",
    "tags": "##array",
    "status": "##string"
  },
  "responseMatchesEach": {
    "photoUrls": "##string",
    "tags": {
      "id": "##number",
      "name": "##string"
    }
  }
}
"""

@ignore @inline
Scenario: explore getPetById inline
	You may use this test for quick API exploratorial purposes.
	* call read('getPetById.feature@operation') inlineRequest

Scenario Outline: Test getPetById for <status> status code
	* def req = read(<testDataFile>)
	* def result = call read('getPetById.feature@operation') req
	* match result.responseStatus == <status>
		Examples:
		| status | testDataFile |
		| 200 | 'test-data/getPetById_200.yml' |
		| 400 | 'test-data/getPetById_400.yml' |
		| 404 | 'test-data/getPetById_404.yml' |



@ignore @operation
Scenario: getPetById
* def req = __arg
* def authHeader = call read('classpath:karate-auth.js') req.auth
* def headers = karate.merge(req.headers || {}, authHeader || {})
Given path '/pet/', req.params.petId
And headers headers
When method GET

* if (req.matchResponse === true) karate.call('getPetById.feature@validate')

@ignore @validate
Scenario: validate getPetById

* def expectedStatusCode = req.statusCode || responseStatus
* match responseStatus == expectedStatusCode

# match response schema in 'test-data' or any object
* def responseContains = req.matchResponse === true? req.responseMatch : responseType == 'json'? {} : ''
* match  response contains responseContains

# validate nested array: photoUrls
* def photoUrls_EachContains = req.matchResponse === true && req.responseMatchesEach && req.responseMatchesEach.photoUrls? req.responseMatchesEach.photoUrls : {}
* def photoUrls_Response = response.photoUrls || []
* match each photoUrls_Response contains photoUrls_EachContains
# validate nested array: tags
* def tags_EachContains = req.matchResponse === true && req.responseMatchesEach && req.responseMatchesEach.tags? req.responseMatchesEach.tags : {}
* def tags_Response = response.tags || []
* match each tags_Response contains tags_EachContains
