
(define (domain delivery-robot)
  (:requirements :strips :typing)
  
  (:types location robot package - object)
  
  (:constants
    home - location
    office - location
    warehouse - location
    r1 - robot
    pkg1 - package
    pkg2 - package
  )
  
  (:predicates
    (at ?r - robot ?l - location)
    (holding ?r - robot ?p - package)
    (free ?r - robot)
    (delivered ?p - package)
    (location_of ?p - package ?l - location)
  )
  
  (:action pickup
    :parameters (?r - robot ?p - package ?l - location)
    :precondition (and (at ?r ?l) (free ?r) (location_of ?p ?l))
    :effect (and (not (free ?r)) (holding ?r ?p) (not (location_of ?p ?l)))
  )
  
  (:action dropoff
    :parameters (?r - robot ?p - package ?l - location)
    :precondition (and (at ?r ?l) (holding ?r ?p))
    :effect (and (free ?r) (delivered ?p) (at ?p ?l))
  )
  
  (:action move
    :parameters (?r - robot ?from ?to - location)
    :precondition (and (at ?r ?from))
    :effect (and (not (at ?r ?from)) (at ?r ?to))
  )
)
