
(define (domain robotic-ball-transport)
  (:requirements :strips)

  (:types room robot ball - object)

  (:predicates
    (carrying ?r - robot ?b - ball)
    (inroom ?o - object ?r - room)
    (at ?r - robot ?r_dest - room)
  )

  (:action pickup
    :parameters (?r - robot ?b - ball ?fromRoom - room)
    :precondition (and (at ?r ?fromRoom) (inroom ?b ?fromRoom))
    :effect (and (not (inroom ?b ?fromRoom)) (carrying ?r ?b) (not (at ?r ?fromRoom)) (at ?r ?fromRoom))
  )

  (:action putdown
    :parameters (?r - robot ?b - ball ?toRoom - room)
    :precondition (and (carrying ?r ?b) (at ?r ?toRoom))
    :effect (and (not (carrying ?r ?b)) (inroom ?b ?toRoom) (not (at ?r ?toRoom)) (at ?r ?toRoom))
  )

  (:action move
    :parameters (?r1 - robot ?r2 - room)
    :precondition (at ?r1 ?r1)
    :effect (and (not (at ?r1 ?r1)) (at ?r1 ?r2))
  )
)
