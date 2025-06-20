@REQ_STF-001 @marvel @agente4
Feature: API Marvel prueba 2025

    Background:
        * def manSysProp = Java.type('com.pichincha.utils.ManegeSystemProperties')

    @id:1 @getMarvel
    Scenario: T-API-STF-001-CA1- Consulta Marvel Exitosa
        * header content-type = 'application/json'
        Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters'
        When method GET
        Then status 200
        And print response
        And def formatName = '#string'
        And match each response[*].name contains formatName

    @id:2 @getMarvelById
    Scenario: T-API-STF-001-CA2- Consulta Marvel Por Id Exitosa
        * header content-type = 'application/json'
        Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters/163'
        When method GET
        Then status 200
        And print response

    @id:3 @getMarvelByIdError
    Scenario: T-API-STF-001-CA3- Consulta Marvel Por Id Error
        * header content-type = 'application/json'
        Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters/999'
        When method GET
        Then status 404
        And print response

    @id:4 @postMarvel
    Scenario: T-API-STF-001-CA4- Crear Personaje Marvel
        * header content-type = 'application/json'
        Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters'
        And def character = read('classpath:../data/marvel/MarvelPersonajeDara.json')
        And request character.hero1.create
        And print character.hero1.create
        When method POST
        Then status 201
        * string saveResponse = response
        * def setProperty = manSysProp.setProp("ResponseSaved",saveResponse)
        * print setProperty
        And print response

    @id:5 @postMarvelError
    Scenario: T-API-STF-001-CA5- Crear Personaje Marvel Error
        * header content-type = 'application/json'
        Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters'
        And def character = read('classpath:../data/marvel/MarvelPersonajeDara.json')
        And request character.hero2
        And print character.hero2
        When method POST
        Then status 400
        And print response
        And match response.error == 'Character name already exists'

    @id:6 @postMarvelEmptyBody
    Scenario: T-API-STF-001-CA6- Crear Personaje Marvel Cuerpo Vacío
        * header content-type = 'application/json'
        Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters'
        And def character = read('classpath:../data/marvel/MarvelPersonajeDara.json')
        And request character.hero3
        And print character.hero3
        When method POST
        Then status 400
        And print response
        And match response.name == 'Name is required'

    @id:7 @putMarvel
    Scenario: T-API-STF-001-CA7- Actualizar Personaje Marvel
        * header content-type = 'application/json'
        * json lastResponse = manSysProp.getProp("ResponseSaved")
        * print lastResponse
        * def id = lastResponse.id
        * print id
        Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters/'+id
        And def character = read('classpath:../data/marvel/MarvelPersonajeDara.json')
        And request character.hero1.update
        And print character.hero1.update
        When method PUT
        Then status 200
        And print response

    @id:8 @putMarvelError
    Scenario: T-API-STF-001-CA8- Actualizar Personaje Marvel Error
        * header content-type = 'application/json'
        Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters/999'
        And def character = read('classpath:../data/marvel/MarvelPersonajeDara.json')
        And request character.hero1.update
        And print character.hero1.update
        When method PUT
        Then status 404
        And print response
        And match response.error == 'Character not found'

    @id:9 @deleteMarvel
    Scenario: T-API-STF-001-CA9- Eliminar Personaje Marvel
        * header content-type = 'application/json'
        Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters/1154'
        When method DELETE
        Then status 204

    @id:10 @deleteMarvelError
    Scenario: T-API-STF-001-CA10- Eliminar Personaje Marvel Error
        * header content-type = 'application/json'
        Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters/999'
        When method DELETE
        Then status 404
        And print response
        And match response.error == 'Character not found'
