
(define (domain robots-with-grippers)
  (:requirements :strips :typing)
  
  (:types robot location container gripper_state object)
  
  (:predicates
    (at ?r - robot ?l - location)
    (in ?o - object ?c - container)
    (on-floor ?o - object)
    (on-table ?o - object)
    (held ?gripper - gripper_state ?o - object)
    (free ?gripper - gripper_state)
    (clear ?o - object)
    (connected ?l1 - location ?l2 - location))
  
  (:action pick-up
    :parameters (?r - robot ?o - object ?l - location ?g - gripper_state)
    :precondition (and (at ?r ?l) (on-floor ?o) (free ?g) (clear ?o))
    :effect (and (not (on-floor ?o)) (held ?g ?o)))
  
  (:action put-down
    :parameters (?r - robot ?o - object ?l - location ?g - gripper_state)
    :precondition (and (at ?r ?l) (held ?g ?o))
    :effect (and (on-floor ?o) (free ?g)))
  
  (:action move
    :parameters (?r - robot ?l1 - location ?l2 - location)
    :precondition (and (at ?r ?l1) (connected ?l1 ?l2))
    :effect (and (not (at ?r ?l1)) (at ?r ?l2)))
  
  (:action grab-object
    :parameters (?r - robot ?o - object ?l - location ?g - gripper_state)
    :precondition (and (at ?r ?l) (on-table ?o) (clear ?o) (free ?g))
    :effect (and (held ?g ?o) (not (on-table ?o)) (not (clear ?o))))
  
  (:action release-object
    :parameters (?r - robot ?o - object ?l - location ?g - gripper_state)
    :precondition (and (at ?r ?l) (held ?g ?o))
    :effect (and (on-table ?o) (clear ?o) (not (held ?g ?o)))))
