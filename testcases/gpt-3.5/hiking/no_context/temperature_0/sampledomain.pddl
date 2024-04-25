
(define (domain circular_walk)
  (:requirements :strips :typing)
  
  (:types
    location car - object
  )
  
  (:predicates
    (at ?car - car ?loc - location)
    (driven ?car - car)
    (walked ?loc1 - location ?loc2 - location)
    (tired)
    (tent_up)
    (ready)
  )
  
  (:action drive
    :parameters (?car - car ?from - location ?to - location)
    :precondition (at ?car ?from)
    :effect (and (at ?car ?to) (driven ?car) (not (at ?car ?from)))
  )
  
  (:action walk
    :parameters (?loc1 - location ?loc2 - location)
    :precondition (and (at car1 ?loc1) (at car2 ?loc1) (not (driven car1)) (not (driven car2)) (not (walked ?loc1 ?loc2)) (tired) (tent_up))
    :effect (and (walked ?loc1 ?loc2) (tired) (not (tent_up)) (ready))
  )
)
