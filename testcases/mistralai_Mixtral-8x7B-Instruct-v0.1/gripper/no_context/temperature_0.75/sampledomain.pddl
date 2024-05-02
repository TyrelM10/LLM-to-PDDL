
(define (domain robots-with-grippers)
(:requirements :strips :typing)

; Define types of objects in this domain
(:types room ball gripper)

; Declare predicates that describe properties of state
(:predicates
	(carrying ?r - gripper ?b - ball)      ; Gripper 'r' carries ball 'b'
	(at ?x - ball ?r - room)               ; Ball 'x' is at room 'r'
	(free ?g - gripper)                   ; Gripper 'g' is free
	(empty ?r - room))                     ; Room 'r' has no more balls

; Declare actions using STRIPS syntax
(:action pickup
	:parameters (?g - gripper ?b - ball ?r1 - room ?r2 - room)
	:precondition (and (at ?b ?r1) (free ?g) (empty ?r2))
	:effect (and (not (at ?b ?r1)) (not (empty ?r2)) (carrying ?g ?b)))

(:action putdown
	:parameters (?g - gripper ?b - ball ?r - room)
	:precondition (carrying ?g ?b)
	:effect (and (at ?b ?r) (free ?g) (empty ?g)))

(:action moveball_remove
	:parameters (?b - ball ?r1 - room)
	:precondition (and (at ?b ?r1) (empty ?r1))
	:effect (not (at ?b ?r1)))

(:action moveball_add
	:parameters (?b - ball ?r2 - room)
	:precondition (empty ?r2)
	:effect (and (at ?b ?r2))))
