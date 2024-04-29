
(define (domain delivery)
  (:requirements :strips)
  
  (:types location city vehicle package)

  (:predicates
    (location_in ?x - location (?y - city))
    (airport ?x - location)
    (truck ?x - vehicle)
    (plane ?x - vehicle)
    (at ?v - vehicle ?l - location)
    (carrying ?v - vehicle ?pkg - package)
    (carryable ?pkg - package)
    (free ?pkg - package)
    (delivered ?pkg - package)
  )

  (:action move-vehicle
    :parameters (?v - vehicle ?from - location ?to - location)
    :precondition (and (at ?v ?from) (not (at ?v ?to)))
    :effect (and (not (at ?v ?from)) (at ?v ?to))
  )

  (:action load-package
    :parameters (?v - vehicle ?pkg - package ?loc - location)
    :precondition (and (at ?v ?loc) (not (carrying ?v ?pkg)) (carryable ?pkg) (free ?pkg))
    :effect (and (carrying ?v ?pkg) (not (at ?v ?loc)) (not (free ?pkg)))
  )

  (:action unload-package
    :parameters (?v - vehicle ?pkg - package ?loc - location)
    :precondition (and (at ?v ?loc) (carrying ?v ?pkg) (delivered ?pkg))
    :effect (and (not (carrying ?v ?pkg)) (at ?v ?loc) (free ?pkg))
  )

  (:action fly
    :parameters (?p - plane ?src - airport ?dst - airport)
    :precondition (and (at ?p ?src) (airport ?src) (airport ?dst))
    :effect (move-vehicle ?p ?src ?dst)
  )

  (:action drive
    :parameters (?t - truck ?src - location ?dst - location)
    :precondition (and (at ?t ?src) (location_in ?src ?city) (location_in ?dst ?city))
    :effect (move-vehicle ?t ?src ?dst)
  )

  (:action pickup
    :parameters (?t - truck ?pkg - package ?loc - location)
    :precondition (and (at ?t ?loc) (carryable ?pkg) (free ?pkg))
    :effect (load-package ?t ?pkg ?loc)
  )

  (:action dropoff
    :parameters (?p - plane ?pkg - package ?loc - airport)
    :precondition (and (at ?p ?loc) (carrying ?p ?pkg) (delivered ?pkg))
    :effect (unload-package ?p ?pkg ?loc)
  )
)
