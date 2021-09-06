Feature: Find purchase order by ID
	For valid response try integer IDs with value &lt;= 5 or &gt; 10. Other values will generated exceptions

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
    "orderId": 0
  },
  "body": null,
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
Scenario: explore getOrderById inline
	You may use this test for quick API exploratorial purposes.
	* call read('getOrderById.feature@operation') inlineRequest

Scenario Outline: Test getOrderById for <status> status code
	* def req = read(<testDataFile>)
	* def result = call read('getOrderById.feature@operation') req
	* match result.responseStatus == <status>
		Examples:
		| status | testDataFile |
		| 200 | 'test-data/getOrderById_200.yml' |
		| 400 | 'test-data/getOrderById_400.yml' |
		| 404 | 'test-data/getOrderById_404.yml' |



@ignore @operation
Scenario: getOrderById
* def req = __arg
* def authHeader = call read('classpath:karate-auth.js') req.auth
* def headers = karate.merge(req.headers || {}, authHeader || {})
Given path '/store/order/', req.params.orderId
And headers headers
When method GET

* if (req.matchResponse === true) karate.call('getOrderById.feature@validate')

@ignore @validate
Scenario: validate getOrderById

* def expectedStatusCode = req.statusCode || responseStatus
* match responseStatus == expectedStatusCode

# match response schema in 'test-data' or any object
* def responseContains = req.matchResponse === true? req.responseMatch : responseType == 'json'? {} : ''
* match  response contains responseContains

