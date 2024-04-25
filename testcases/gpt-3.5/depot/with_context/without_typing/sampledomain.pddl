(define (domain logistics-blocks)
  (:requirements :strips)
  (:types object truck pallet)
  (:predicates 
    (at ?obj - object ?loc - object)
    (on ?c - object ?p - pallet)
    (empty ?t - truck)
    (loaded ?t - truck ?c - object)
    (clear ?p - pallet)
    (hoist-empty)
    (holding ?c - object)
  )

  (:action load
    :parameters (?t - truck ?c - object)
    :precondition (and (at ?t ?loc) (at ?c ?loc) (empty ?t))
    :effect (and (loaded ?t ?c) (not (empty ?t)))
  )

  (:action unload
    :parameters (?t - truck ?c - object)
    :precondition (and (at ?t ?loc) (loaded ?t ?c))
    :effect (and (not (loaded ?t ?c)) (empty ?t))
  )

  (:action transport
    :parameters (?t - truck ?from - object ?to - object)
    :precondition (and (at ?t ?from) (empty ?t))
    :effect (and (at ?t ?to) (not (at ?t ?from)))
  )

  (:action stack
    :parameters (?c - object ?p - pallet)
    :precondition (and (holding ?c) (clear ?p))
    :effect (and (on ?c ?p) (clear ?c) (not (holding ?c)))
  )

  (:action pick-up
    :parameters (?c - object)
    :precondition (and (at ?c ?loc) (clear ?c) (hoist-empty))
    :effect (and (holding ?c) (not (clear ?c)) (not (hoist-empty)))
  )

  (:action drop
    :parameters (?c - object)
    :precondition (holding ?c)
    :effect (and (clear ?c) (hoist-empty) (not (holding ?c)))
  )
)
