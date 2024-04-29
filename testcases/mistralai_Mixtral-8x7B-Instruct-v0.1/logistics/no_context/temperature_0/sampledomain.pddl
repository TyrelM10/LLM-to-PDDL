 (define (domain delivery)
(:requirements :strips)
(:types location package person vehicle)
(:predicates
	(at ?x - object ?y - location)
	(holding ?x - package ?y - person)
	(carrying ?x - package ?y - vehicle)
)
(:action pick-up
	:parameters (?p - package ?l - location ?p2 - person)
	:precondition (and (at ?p ?l) (at ?p2 ?l))
	:effect (and (not (at ?p ?l)) (holding ?p ?p2))
)
(:action put-down
	:parameters (?p - package ?l - location ?p2 - person)
	:precondition (holding ?p ?p2)
	:effect (and (at ?p ?l) (not (holding ?p ?p2)))
)
(:action load
	:parameters (?p - package ?v - vehicle ?l - location ?p2 - person)
	:precondition (and (at ?v ?l) (at ?p ?l) (holding ?p ?p2))
	:effect (and (not (holding ?p ?p2)) (carrying ?p ?v))
)
(:action unload
	:parameters (?p - package ?v - vehicle ?l - location ?p2 - person)
	:precondition (carrying ?p ?v)
	:effect (and (at ?p ?l) (holding ?p ?p2) (not (carrying ?p ?v)))
)
)