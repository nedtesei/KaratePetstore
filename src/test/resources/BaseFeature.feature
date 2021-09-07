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

Scenario Outline: Add new pet <id> <name> <category> <status>
Given path 'pet'
* def myPet = 
"""
{
  "id": '#(id)',
  "name": #(name),
  "category": {
    "id": 1,
    "name": '#(category)'
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
  "status": #(status)
}
"""
* print myPet
Given request myPet
When method POST
Then assert responseStatus == 200
* print response

Examples:
| id | name  | category | status    |
| 1  | dog   | one      | available |
| 2  | cat   | two      | available |
| 3  | bird  | three    | sold      |

Scenario Outline: Add new pet wit var category <id> <name> <category> <status>
Given path 'pet'
* def myCategory = { "id": 1, "name": '#(category)' }
* def myPet = 
"""
{
  "id": '#(id)',
  "name": #(name),
  "category": #(myCategory),
  "photoUrls": [
    "string"
  ],
  "tags": [
    {
      "id": 0,
      "name": "string"
    }
  ],
  "status": #(status)
}
"""
* print myPet
Given request myPet
When method POST
Then assert responseStatus == 200
* print response

Examples:
| id | name  | category | status    |
| 1  | dog   | one      | available |
| 2  | cat   | two      | available |
| 3  | bird  | three    | sold      |

Scenario: Add new pet from file 1
Given path 'pet'
* def myPetJson = read ('classpath:/data/payload.json')
* def myPetYml = read ('data/payload.yml')
* match myPetJson == myPetYml
# * print myPetYml
# Given request myPet
# When method POST
# Then assert responseStatus == 200
# * print response


Scenario Outline: Add new pet from file dynamic json <id> <name> <category> <status>
Given path 'pet'
* def myCategory = { "id": 1, "name": '#(category)' }
* def myPet = read ('data/payload-dynamic.json')
* print myPet
 Given request myPet
 When method POST
 Then assert responseStatus == 200
 * print response
Examples:
| id | name  | category | status    |
| 1  | dog   | one      | available |
| 2  | cat   | two      | available |
| 3  | bird  | three    | sold      |

Scenario Outline: Add new pet from file dynamic yml <id> <name> <category> <status>
Given path 'pet'
* def myCategory = { "id": 1, "name": '#(categ)' }
* def myPet1 = read ('data/payload-dynamic.yml')
* print myPet1
 Given request myPet1
 When method POST
 Then assert responseStatus == 200
 * print response
Examples:
| id | name  | categ | status    |
| 1  | dog   | one   | available |
| 2  | cat   | two   | available |
| 3  | bird  | three | sold      |


Scenario: Formate Date
 * def log = function(str) { karate.log(str)}
 * log('Hola mundo')

 * def getDate =
  """
  function() {
    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
    var sdf = new SimpleDateFormat('yyyy/MM/dd');
    var date = new java.util.Date();
    return sdf.format(date);
  } 
  """
  * def temp = getDate()
  * print 'temp:' + temp
  * def dateFormat = new java.text.SimpleDateFormat('yyyy/MM/dd')
  * def temp2 = dateFormat.format(new java.util.Date())
  * print 'temp2:' +temp2