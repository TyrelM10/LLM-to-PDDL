(define (problem transportation_problem)
    (:domain transportation)
    (:objects
        truck1 airplane1 - object
        city1 city2 - city
        location1 location2 location3 - location
        package1 package2 - object
    )
    (:init
        (at truck1 location1)
        (at airplane1 location1)
        (connected city1 city2)
        (at_airport location1)
        (at_airport location2)
        (at_airport location3)
        (can_drive truck1)
        (can_fly airplane1)
        (in package1 location1)
        (in package2 location3)
    )
    (:goal (and 
        (at package1 location2)
        (at package2 location1)
    ))
)