(define (domain city-logistics)
  (:requirements :strips :typing)
  (:types
    location airport city package vehicle airplane truck)
  
  (:predicates
    (at ?p - package ?l - location)
    (in-city ?l - location ?c - city)
    (at-vehicle ?v - vehicle ?l - location)
    (at-airport ?a - airport ?c - city)
    (road-connected ?l1 ?l2 - location)
    (air-route ?a1 ?a2 - airport)
  )

  (:action drive
    :parameters (?t - truck ?from ?to - location ?c - city)
    :precondition (and (at-vehicle ?t ?from) (in-city ?from ?c) (in-city ?to ?c) (road-connected ?from ?to))
    :effect (and (not (at-vehicle ?t ?from)) (at-vehicle ?t ?to))
  )

  (:action fly
    :parameters (?a - airplane ?from ?to - airport ?c1 ?c2 - city)
    :precondition (and (at-vehicle ?a ?from) (at-airport ?from ?c1) (at-airport ?to ?c2) (air-route ?from ?to))
    :effect (and (not (at-vehicle ?a ?from)) (at-vehicle ?a ?to))
  )

  (:action load-package
    :parameters (?p - package ?v - vehicle ?l - location)
    :precondition (and (at ?p ?l) (at-vehicle ?v ?l))
    :effect (not (at ?p ?l))
  )

  (:action unload-package
    :parameters (?p - package ?v - vehicle ?l - location)
    :precondition (at-vehicle ?v ?l)
    :effect (at ?p ?l)
  )
)
