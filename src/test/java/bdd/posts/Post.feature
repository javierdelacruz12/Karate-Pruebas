Feature:Post endpoint test

  Scenario:verificar un usuario en especifico
  Given url 'https://jsonplaceholder.typicode.com'
    When method get
    And path 'posts'
    And param userId = 2
    When method get
    Then status 200
    And assert response.length > 1
    And match responseType == 'json'



    #* print "RESPONSE:" , response [0].title
    #* print "RESPONSE:" , response.length




