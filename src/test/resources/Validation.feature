Feature: Validation

Background:
* url baseUrl

@ignore @operation
Scenario: getPetById validation contains
* def req = {"params": { "petId": 0 }}
* def authHeader = call read('classpath:karate-auth.js') req.auth
* def headers = karate.merge(req.headers || {}, authHeader || {})
Given path '/pet/', req.params.petId
And headers headers
When method GET
* print response
* def expected = 
"""
{
 "id": '#number',
 "name": '#string',
 "category":
    {
        "id": '#number',
        "name": '#string'
    },
 "photoUrls": '#array'
}
"""
* match response contains expected
# photoUrls should be an array of strings each of length > 1
* match response.photoUrls == "#[] #string ? _.length > 1 "

@ignore @operation
Scenario: getPetById validation contains deep
* def req = {"params": { "petId": 0 }}
* def authHeader = call read('classpath:karate-auth.js') req.auth
* def headers = karate.merge(req.headers || {}, authHeader || {})
Given path '/pet/', req.params.petId
And headers headers
When method GET
* print response
* def expected = 
"""
{
 "id": '#number',
 "name": '#string? _.length > 1',
 "category":
    {
        "id": '#number',
        "name": '#string'
    },
 "photoUrls": '#string',
 "tags": '#object'
}
"""
* match response contains deepexpected
# photoUrls should be an array with size > 1
* match response.photoUrls == "_.length > 1"
# photoUrls should be an array of strings each of length > 1
* match response.photoUrls == "#[] #string ? _.length > 1"

