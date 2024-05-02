
(define (domain robots-with-grippers)
  (:requirements :strips :typing)

  ;; Define types of objects
  (:types robot object room robot-room)

  (:constants
    left-gripper right-gripper   ; Two possible grippers
    room1 room2 room3           ; Example room names
    robot1 robot2              ; Example robot names
  )

  (:predicates
    (ball ?x - object)             ; An object is a ball
    (inroom ?x - object ?r - room)  ; Object x is in room r
    (free ?r - robot)              ; Robot r is free
    (carrying ?r - robot ?b - object) ; Robot r is carrying ball b
    (at ?r - robot ?loc - room)     ; Robot r is at location loc
    (adjacent ?r1 - room ?r2 - room) ; Room r1 is adjacent to room r2
  )

  ;; Actions
  (:action pickup
    :parameters (?r - robot ?o - object ?from - room)
    :precondition (and (free ?r) (ball ?o) (inroom ?o ?from))
    :effect (and (not (free ?r)) (carrying ?r ?o) (not (inroom ?o ?from)) (not (at ?r from)))
  )

  (:action putdown
    :parameters (?r - robot ?o - object ?to - room)
    :precondition (and (carrying ?r ?o) (free ?to) (adjacent ?to (current-room ?r)))
    :effect (and (free ?r) (inroom ?o ?to) (not (carrying ?r ?o)) (at ?r ?to))
  )

  (:action move
    :parameters (?r - robot ?to - room)
    :precondition (and (free ?r) (adjacent (current-room ?r) ?to))
    :effect (and (not (at ?r (current-room ?r))) (at ?r ?to) (not (free ?r)) (free (current-room ?r)))
  )
)
