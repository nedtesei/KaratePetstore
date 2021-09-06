Feature: Place an order for a pet
	Place a new order in the store

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
    "petId": 198772,
    "quantity": 7,
    "shipDate": "fill some value",
    "status": "approved",
    "complete": true
  },
  "matchResponse": false,
  "responseMatch": {
    "id": "##number",
    "petId": "##number",
    "quantity": "##number",
    "shipDate": "##string",
    "status": "##string",
    "complete": "##boolean"
  },
  "responseMatchesEach": {}
}
"""

@ignore @inline
Scenario: explore placeOrder inline
	You may use this test for quick API exploratorial purposes.
	* call read('placeOrder.feature@operation') inlineRequest

Scenario Outline: Test placeOrder for <status> status code
	* def req = read(<testDataFile>)
	* def result = call read('placeOrder.feature@operation') req
	* match result.responseStatus == <status>
		Examples:
		| status | testDataFile |
		| 200 | 'test-data/placeOrder_200.yml' |
		| 405 | 'test-data/placeOrder_405.yml' |



@ignore @operation
Scenario: placeOrder
* def req = __arg
* def authHeader = call read('classpath:karate-auth.js') req.auth
* def headers = karate.merge(req.headers || {}, authHeader || {})
Given path '/store/order'
And headers headers
And request req.body
When method POST

* if (req.matchResponse === true) karate.call('placeOrder.feature@validate')

@ignore @validate
Scenario: validate placeOrder

* def expectedStatusCode = req.statusCode || responseStatus
* match responseStatus == expectedStatusCode

# match response schema in 'test-data' or any object
* def responseContains = req.matchResponse === true? req.responseMatch : responseType == 'json'? {} : ''
* match  response contains responseContains

