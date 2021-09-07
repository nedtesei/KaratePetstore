@test
Feature: Nom de la feature
Text de la descripcio
Descripcio 1
Descrpcio 2

Background:
 # url 'https://petstore3.swagger.io/api/v3'
* print 'esta a background'
* url miVariableUrl

Scenario:
* print 'esta a un escenari'

@ignore
Scenario Outline:
* print 'esta a un escenari: ' + nomDia
Examples:
| dia   | nomDia |
| 1     | dilluns |
| 2     | dimarts |

Scenario: Find Pets by Status
Given url 'https://petstore3.swagger.io/api/v3/pet/findByStatus?status=available'
When method GET
* print response


Scenario: Find Pets by Tags
Given url 'https://petstore3.swagger.io/api/v3/pet/findByTags?tags=one'
When method GET
* print response

Scenario: Find Pets by Status 200
comentario libre
Given path 'pet/findByStatus'
And param status = 'available'
When method GET
Then assert responseStatus == 200
* print response


Scenario: Find Pets by Status 400
comentario libre
Given path 'pet/findByStatus'
And param status = 'availablexx'
When method GET
Then assert responseStatus == 400
* print response

Scenario: Add new pet
Given path 'pet'
* def myPet = 
"""
{
  "id": 10,
  "name": "doggie",
  "category": {
    "id": 1,
    "name": "Dogs"
  },
  "photoUrls": [
    "string"
  ],
  "tags": [
    {
      "id": 0,
      "name": "string"
    }
  ],
  "status": "available"
}
"""
* print myPet
Given request myPet
When method POST
Then assert responseStatus == 200
* print response