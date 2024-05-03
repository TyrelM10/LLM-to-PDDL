(define (problem city-logistics-problem)
  (:domain city-logistics)
  (:objects
    package1 package2 - package
    loc1 loc2 loc3 - location
    airport1 airport2 - airport
    city1 city2 - city
    truck1 - truck
    airplane1 - airplane
  )

  (:init
    (at package1 loc1)
    (at package2 loc2)
    (in-city loc1 city1)
    (in-city loc2 city1)
    (in-city loc3 city2)
    (road-connected loc1 loc2)
    (at-vehicle truck1 loc1)
    (at-vehicle airplane1 airport1)
    (at-airport airport1 city1)
    (at-airport airport2 city2)
    (air-route airport1 airport2)
  )

  (:goal
    (and
      (at package1 loc3)
      (at package2 loc3)
    )
  )
)
