
(define (domain transportation)
  (:requirements :strips)
  
  (:types
    city location airport truck airplane package - object
  )
  
  (:predicates
    (in-city ?c - city ?l - location)
    (in-location ?l - location)
    (is-airport ?l - location)
    (is-truck ?t - truck)
    (is-airplane ?a - airplane)
    (truck-at ?t - truck ?l - location)
    (airplane-at ?a - airplane ?l - location)
    (has-package ?l - location ?p - package)
    (needs-package ?l - location ?p - package)
    (delivered ?p - package)
  )

  (:action drive
    :parameters (?t - truck ?from - location ?to - location)
    :precondition (and (is-truck ?t) (in-location ?from) (in-location ?to) (in-city ?c ?from) (in-city ?c ?to) (truck-at ?t ?from))
    :effect (and (truck-at ?t ?to) (not (truck-at ?t ?from)))
  )

  (:action fly
    :parameters (?a - airplane ?from - location ?to - location)
    :precondition (and (is-airplane ?a) (in-location ?from) (in-location ?to) (is-airport ?from) (is-airport ?to) (airplane-at ?a ?from))
    :effect (and (airplane-at ?a ?to) (not (airplane-at ?a ?from)))
  )

  (:action load
    :parameters (?t - truck ?l - location ?p - package)
    :precondition (and (is-truck ?t) (in-location ?l) (truck-at ?t ?l) (has-package ?l ?p) (needs-package ?l ?p))
    :effect (and (not (has-package ?l ?p)) (not (needs-package ?l ?p)))
  )

  (:action unload
    :parameters (?t - truck ?l - location ?p - package)
    :precondition (and (is-truck ?t) (in-location ?l) (truck-at ?t ?l) (has-package ?l ?p))
    :effect (and (has-package ?l ?p) (delivered ?p))
  )
)
