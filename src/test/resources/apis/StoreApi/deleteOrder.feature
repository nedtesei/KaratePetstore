Feature: Delete purchase order by ID
	For valid response try integer IDs with value &lt; 1000. Anything above 1000 or nonintegers will generate API errors

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
    "orderId": 0
  },
  "body": null,
  "matchResponse": false,
  "responseMatch": null,
  "responseMatchesEach": {}
}
"""

@ignore @inline
Scenario: explore deleteOrder inline
	You may use this test for quick API exploratorial purposes.
	* call read('deleteOrder.feature@operation') inlineRequest

Scenario Outline: Test deleteOrder for <status> status code
	* def req = read(<testDataFile>)
	* def result = call read('deleteOrder.feature@operation') req
	* match result.responseStatus == <status>
		Examples:
		| status | testDataFile |
		| 400 | 'test-data/deleteOrder_400.yml' |
		| 404 | 'test-data/deleteOrder_404.yml' |



@ignore @operation
Scenario: deleteOrder
* def req = __arg
* def authHeader = call read('classpath:karate-auth.js') req.auth
* def headers = karate.merge(req.headers || {}, authHeader || {})
Given path '/store/order/', req.params.orderId
And headers headers
When method DELETE

* if (req.matchResponse === true) karate.call('deleteOrder.feature@validate')

@ignore @validate
Scenario: validate deleteOrder

* def expectedStatusCode = req.statusCode || responseStatus
* match responseStatus == expectedStatusCode
