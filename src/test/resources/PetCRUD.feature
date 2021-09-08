Feature: Pet CRUD test

Scenario: CRUD

# Crear Pet
* def pet = 
"""
{ 
  "id": -77,
  "name": "canet",
  "category": {
    "id": 1,
    "name": "mascotes peludes"
  },
  "photoUrls": [
    "http://images/tata"
  ],
  "tags": [
    {
      "id": 0,
      "name": "canet"
    }
  ],
  "status": "available"
}  
}
"""
* def addPetResult = call read('classpath:apis/PetApi/addPet.feature@operation') { body : #(pet) }
* print addPetResult.response

# leer pet creado
* def getPetResult = call read('classpath:apis/PetApi/getPetById.feature@operation') { params: { petId: #(addPetResult.response.id) }}
* print getPetResult.response

# modificando los datos del pet
* copy createdPet = getPetResult.response
* set createdPet.tags[0].id = 10
* set createdPet.tags[0].name = 'moix'
* print createdPet

# actualizar pet
* def updatedPetResult = call read('classpath:apis/PetApi/updatePet.feature@operation') { body: #(createdPet) }
* print updatedPetResult.response
* print updatedPetResult.response
* match updatedPetResult.response.tags[0].id == 10
* match updatedPetResult.response.tags[0].name == 'moix'

# borrar pet
* def deletedPetResult = call read('classpath:apis/PetApi/deletePet.feature@operation') { params: { petId: #(updatedPetResult.response.id) }}
* match deletedPetResult.responseStatus == 200

# leer el pet y ver que no esta
* def getPetResult2 = call read('classpath:apis/PetApi/getPetById.feature@operation') { params: { petId: #(createdPet.id) }}
* match getPetResult2.responseStatus == 404