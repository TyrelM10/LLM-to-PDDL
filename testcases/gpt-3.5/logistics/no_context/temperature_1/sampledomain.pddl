
(define (domain transportation)
  (:requirements :strips)
  
  (:types
    city location vehicle package - object
    airplane truck - vehicle
    airport - location
  )

  (:predicates
    (at ?v - vehicle ?l - location)
    (in_city ?l - location ?c - city)
    (is_airport ?l - location)
    (delivered ?p - package)
    (can_drive ?v - truck)
    (can_fly ?v - airplane)
  )

  (:action move
    :parameters (?v - vehicle ?from - location ?to - location)
    :precondition (and (at ?v ?from) (in_city ?from ?c) (in_city ?to ?c))
    :effect (and (at ?v ?to) (not (at ?v ?from)))
  )

  (:action load
    :parameters (?pkg - package ?v - vehicle ?l - location)
    :precondition (and (at ?v ?l) (at ?pkg ?l) (delivered ?pkg))
    :effect (and (delivered ?pkg))
  )
  
  (:action deliver
    :parameters (?pkg - package ?v - vehicle ?l - location)
    :precondition (and (at ?v ?l) (at ?pkg ?l) (delivered ?pkg))
    :effect (and (delivered ?pkg) (not (at ?pkg ?l)))
  )
)
