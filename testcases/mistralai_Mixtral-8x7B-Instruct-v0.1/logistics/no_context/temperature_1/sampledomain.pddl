
(define (domain delivery)
  (:requirements :strips)
  (:types city location airport truck plane package - object)
  (:predicates
    (connected ?x - location ?y - location)
    (at ?v - location ?l - location)
    (carrying ?t - truck ?p - package)
    (free ?t - truck)
    (airport-location ?a - airport)
    (loaded ?p - package)
    (unloaded ?p - package)
    (at-airport ?p - package ?a - airport)
    (at-location ?o - object ?l - location))
  
  (:action Drive
    :parameters (?t - truck ?f - location ?t2 - location)
    :precondition (and (at ?t ?f) (connected ?f ?t2) (free ?t))
    :effect (and (not (free ?t)) (at ?t ?t2)))

  (:action Pickup
    :parameters (?t - truck ?p - package ?l - location)
    :precondition (and (at ?t ?l) (at-location ?p ?l) (free ?t))
    :effect (and (not (free ?t)) (carrying ?t ?p)))

  (:action Deliver
    :parameters (?t - truck ?p - package ?l - location)
    :precondition (and (carrying ?t ?p) (at ?t ?l) (at-location ?p ?l))
    :effect (and (not (carrying ?t ?p)) (free ?t)))

  (:action Load
    :parameters (?p1 - airport ?p2 - package ?a - airport)
    :precondition (and (at-airport ?p2 ?a) (unloaded ?p2) (at-location ?p1 ?a))
    :effect (and (not (unloaded ?p2)) (loaded ?p2) (at-airport ?p2 ?a)))

  (:action Unload
    :parameters (?p1 - airport ?p2 - package ?a - airport)
    :precondition (and (loaded ?p2) (at-airport ?p2 ?a) (at-location ?p1 ?a))
    :effect (and (unloaded ?p2) (not (at-airport ?p2 ?a))))

  (:action Fly
    :parameters (?p1 - plane ?from - airport ?to - airport)
    :precondition (and (at-airport ?p1 ?from) (connected ?from ?to) (unloaded ?p1))
    :effect (and (not (at-airport ?p1 ?from)) (at-airport ?p1 ?to) (not (unloaded ?p1)))))
