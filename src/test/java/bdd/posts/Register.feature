Feature: Registra Usuario

@Register
  Scenario: Registrar usuario tipo 1
  Given url 'https://reqres.in/api/register'
  * def json = read('../json/register.json')
    Given request json
  When method get
  And status 200
  * def name = response.data[0].name
  * match name == "cerulean"
