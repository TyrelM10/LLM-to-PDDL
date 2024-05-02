
(define (domain delivery-domain)
(:requirements :strips :typing)
(:types city location airport - object truck plane package - object)
(:predicates
	(at ?x - object ?loc - location)
	(free ?v - truck)
	(holding ?v - truck ?p - package))

(:action Drive
	:parameters (?t - truck ?from - location ?to - location)
        :precondition (and (at ?t ?from) (free ?t))
        :effect (and (not (at ?t ?from)) (at ?t ?to)))

(:action Pickup
	:parameters (?t - truck ?loc - location ?pkg - package)
        :precondition (and (at ?t ?loc) (free ?t))
        :effect (and (holding ?t ?pkg))))
