Feature: uploads an image
	

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
    "petId": 0,
    "additionalMetadata": "fill some value"
  },
  "body": "fill some value",
  "matchResponse": false,
  "responseMatch": {
    "code": "##number",
    "type": "##string",
    "message": "##string"
  },
  "responseMatchesEach": {}
}
"""

@ignore @inline
Scenario: explore uploadFile inline
	You may use this test for quick API exploratorial purposes.
	* call read('uploadFile.feature@operation') inlineRequest

Scenario Outline: Test uploadFile for <status> status code
	* def req = read(<testDataFile>)
	* def result = call read('uploadFile.feature@operation') req
	* match result.responseStatus == <status>
		Examples:
		| status | testDataFile |
		| 200 | 'test-data/uploadFile_200.yml' |



@ignore @operation
Scenario: uploadFile
* def req = __arg
* def authHeader = call read('classpath:karate-auth.js') req.auth
* def headers = karate.merge(req.headers || {}, authHeader || {})
Given path '/pet/', req.params.petId, '/uploadImage'
And param additionalMetadata = req.params.additionalMetadata
And headers headers
And request req.body
When method POST

* if (req.matchResponse === true) karate.call('uploadFile.feature@validate')

@ignore @validate
Scenario: validate uploadFile

* def expectedStatusCode = req.statusCode || responseStatus
* match responseStatus == expectedStatusCode

# match response schema in 'test-data' or any object
* def responseContains = req.matchResponse === true? req.responseMatch : responseType == 'json'? {} : ''
* match  response contains responseContains

