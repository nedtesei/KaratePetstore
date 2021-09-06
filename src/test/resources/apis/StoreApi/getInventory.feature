Feature: Returns pet inventories by status
	Returns a map of status codes to quantities

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
  "body": null,
  "matchResponse": false,
  "responseMatch": "##string",
  "responseMatchesEach": {}
}
"""

@ignore @inline
Scenario: explore getInventory inline
	You may use this test for quick API exploratorial purposes.
	* call read('getInventory.feature@operation') inlineRequest

Scenario Outline: Test getInventory for <status> status code
	* def req = read(<testDataFile>)
	* def result = call read('getInventory.feature@operation') req
	* match result.responseStatus == <status>
		Examples:
		| status | testDataFile |
		| 200 | 'test-data/getInventory_200.yml' |



@ignore @operation
Scenario: getInventory
* def req = __arg
* def authHeader = call read('classpath:karate-auth.js') req.auth
* def headers = karate.merge(req.headers || {}, authHeader || {})
Given path '/store/inventory'
And headers headers
When method GET

* if (req.matchResponse === true) karate.call('getInventory.feature@validate')

@ignore @validate
Scenario: validate getInventory

* def expectedStatusCode = req.statusCode || responseStatus
* match responseStatus == expectedStatusCode

# match response schema in 'test-data' or any object
* def responseContains = req.matchResponse === true? req.responseMatch : responseType == 'json'? {} : ''
* match  response contains responseContains

