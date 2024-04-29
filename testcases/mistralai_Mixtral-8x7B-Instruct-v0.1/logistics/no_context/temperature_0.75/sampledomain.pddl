
(define (domain delivery)
  (:types location package person vehicle)
  (:constants
    drone - vehicle
    warehouse - location
    office - location
    pack1 - package
    pack2 - package
    alice - person
    bob - person
  )
  (:action pickup
    :parameters (?p - package ?l - location ?v - vehicle)
    :precondition (and (at-location ?p ?l) (free ?v))
    :effect (and (not (at-location ?p ?l)) (onboard ?p ?v) (not (free ?v)))
  )
  (:action deliver
    :parameters (?p - package ?d - location ?v - vehicle)
    :precondition (and (onboard ?p ?v) (free ?d))
    :effect (and (not (onboard ?p ?v)) (at-location ?p ?d) (free ?d))
  )
  (:action move
    :parameters (?v - vehicle ?src - location ?dst - location)
    :precondition (and (free ?v) (at-location ?v ?src))
    :effect (and (not (at-location ?v ?src)) (at-location ?v ?dst))
  )
  (:action load
    :parameters (?p - package ?v - vehicle)
    :precondition (and (at-location ?p warehouse) (free ?p) (free ?v))
    :effect (and (onboard ?p ?v) (not (free ?p)))
  )
  (:action unload
    :parameters (?p - package ?v - vehicle)
    :precondition (and (onboard ?p ?v) (free ?d))
    :effect (and (at-location ?p warehouse) (not (onboard ?p ?v)) (free ?p))
  ))
