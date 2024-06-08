
Feature: sample karate test script
  for help, see: https://github.com/karatelabs/karate/wiki/IDE-Support

  Background:
    * url 'https://jsonplaceholder.typicode.com'
    * def urlBase = 'https://reqres.in'
    * def usersPath = '/api/users'
    * def loginPath = '/api/login'

@prueba01
  Scenario: get all users and then get the first user by id
    Given path 'users'
    When method get
    Then status 200

    * def first = response[0]

    Given path 'users', first.id
    When method get
    Then status 200
  @prueba02
  Scenario: create a user and then get it by id
    * def user =
      """
      {
        "name": "Test User",
        "username": "testuser",
        "email": "test@user.com",
        "address": {
          "street": "Has No Name",
          "suite": "Apt. 123",
          "city": "Electri",
          "zipcode": "54321-6789"
        }
      }
      """

    Given url 'https://jsonplaceholder.typicode.com/users'
    And request user
    When method post
    Then status 201

    * def id = response.id
    * print 'created id is: ', id

    Given path id
    # When method get
    # Then status 200
    # And match response contains user
  @prueba03
  Scenario: Get users list
    Given url 'https://reqres.in' + '/api/users' + '?page=2'
    When method GET
    Then status 200
  @prueba04
  Scenario: Get users list
    Given url urlBase + usersPath + '?page=2'
    When method GET
    Then status 200
  @prueba05
  Scenario: Get users list and check value in field
    Given url urlBase + usersPath
    When method GET
    Then status 200
    And match $..first_name contains 'Emma'
    And match $..id contains '#notnull'
  @prueba06
  Scenario Outline: As a <description>, I want to get the corresponding response_code <status_code>
    Given url urlBase + loginPath
    And request { 'email': <username> , 'password': <password> }
    When method POST
    * print response
    Then response.status == <status_code>
    Examples:
      |username |password | status_code | description |
      |'eve.holt@reqres.in' |'cityslicka' | 200 | valid user |
      |'eve.holt@reqres.in' |null | 400 | invalid user|
  @prueba07
  Scenario: Put user
    Given url urlBase + usersPath + '/2'
    And request { name: 'morpheus updated',job: 'leader updated' }
    When method PUT
    Then status 200
    And match $.name == 'morpheus updated'
  @prueba08
  Scenario: Post user Data-Driven
    Given url urlBase + usersPath
    And request { name: '#(name)',job: '#(job)' }
    When method POST
    Then status 201



