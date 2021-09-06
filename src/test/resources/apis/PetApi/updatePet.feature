Feature: Update an existing pet
	Update an existing pet by Id

Background:
* url baseUrl
# You may read this inlineRequest as request/response documentation o use it for quick exploratory testing
* def inlineRequest =
"""
{
  "auth": null,
  "statusCode": 200,
  "headers": {},
  "params": null,
  "body": {
    "id": 10,
    "name": "doggie",
    "category": {
      "id": 1,
      "name": "Dogs"
    },
    "photoUrls": [
      "fill some value"
    ],
    "tags": [
      {
        "id": 0,
        "name": "fill some value"
      }
    ],
    "status": "pending"
  },
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
Scenario: explore updatePet inline
	You may use this test for quick API exploratorial purposes.
	* call read('updatePet.feature@operation') inlineRequest

Scenario Outline: Test updatePet for <status> status code
	* def req = read(<testDataFile>)
	* def result = call read('updatePet.feature@operation') req
	* match result.responseStatus == <status>
		Examples:
		| status | testDataFile |
		| 200 | 'test-data/updatePet_200.yml' |
		| 400 | 'test-data/updatePet_400.yml' |
		| 404 | 'test-data/updatePet_404.yml' |
		| 405 | 'test-data/updatePet_405.yml' |



@ignore @operation
Scenario: updatePet
* def req = __arg
* def authHeader = call read('classpath:karate-auth.js') req.auth
* def headers = karate.merge(req.headers || {}, authHeader || {})
Given path '/pet'
And headers headers
And request req.body
When method PUT

* if (req.matchResponse === true) karate.call('updatePet.feature@validate')

@ignore @validate
Scenario: validate updatePet

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
