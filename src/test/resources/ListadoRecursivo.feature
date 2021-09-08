Feature:

Scenario: Busqueda y listado de mascotas
* def petsResults = call read('classpath:apis/PetApi/findPetsByStatus.feature@operation') { "params": {"status": "available"} }
#* print petsResults.response
* def petIds = karate.map(petsResults.response, (pet) => { return { params : { petId: pet.id }}})
* call read('classpath:apis/PetApi/getPetById.feature@operation') petIds
* print 'after gettinf petIds', petIds.length 
#sortira 463

Scenario: Borrar1
* def petsResults = call read('classpath:apis/PetApi/findPetsByStatus.feature@operation') { "params": {"status": "available"} }
* def petIds = karate.map(petsResults.response, (pet) => { return { params : { petId: pet.id }}})
* call read('ListadoRecursivo.feature@ifNegativeIdDeletePet') petIds

@ignore @ifNegativeIdDeletePet
Scenario: Condicional1
# * print params.petId
* eval conditionalScenario = (params.petId > 0) ? 'classpath:apis/PetApi/getPetById.feature@operation': 'classpath:apis/PetApi/deletePet.feature@operation'
# * print 'conditionalScenario', params.petId, conditionalScenario
* call read(conditionalScenario) __arg


Scenario: Borrar2
* def petsResults = call read('classpath:apis/PetApi/findPetsByStatus.feature@operation') { "params": {"status": "available"} }
* def petIds = karate.map(petsResults.response, (pet) => { return { params : { petId: pet.id }}})
* call read('ListadoRecursivo.feature@ifNegativeIdDeletePetWithJs') petIds

@ignore @ifNegativeIdDeletePetWithJs
Scenario: Condicional2
* print '__arg', __arg
* def conditionalFunction =
"""
    if (params.petId > 0) {
        karate.call('classpath:apis/PetApi/getPetById.feature@operation', __arg)
    } else {
        karate.call('classpath:apis/PetApi/deletePet.feature@operation', __arg)
    }
"""
* conditionalFunction()

