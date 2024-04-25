
(define (domain transportation)
  (:requirements :strips)
  
  (:types
    vehicle location - object
    city - location
    truck airplane - vehicle
    package - object
  )
  
  (:predicates
    (at ?v - vehicle ?l - location)
    (in-city ?l - location ?c - city)
    (airport ?l - location)
    (package-at ?p - package ?l - location)
    (goal-achieved)
  )
  
  (:action drive
    :parameters (?t - truck ?from - location ?to - location)
    :precondition (and (at ?t ?from) (in-city ?from ?c) (in-city ?to ?c))
    :effect (and (at ?t ?to) (not (at ?t ?from)))
  )
  
  (:action fly
    :parameters (?a - airplane ?from - location ?to - location)
    :precondition (and (at ?a ?from) (airport ?from) (airport ?to))
    :effect (and (at ?a ?to) (not (at ?a ?from)))
  )
  
  (:action load
    :parameters (?t - truck ?p - package ?l - location)
    :precondition (and (at ?t ?l) (package-at ?p ?l))
    :effect (and (at ?p ?t) (not (package-at ?p ?l)))
  )
  
  (:action unload
    :parameters (?t - truck ?p - package ?l - location)
    :precondition (and (at ?t ?l) (at ?p ?t))
    :effect (and (package-at ?p ?l) (not (at ?p ?t)))
  )
  
  (:action deliver
    :parameters (?p - package ?l - location)
    :precondition (and (at ?p ?t) (at ?t ?l) (goal-achieved))
    :effect (and (package-at ?p ?l) (not (at ?p ?t)))
  )
)
