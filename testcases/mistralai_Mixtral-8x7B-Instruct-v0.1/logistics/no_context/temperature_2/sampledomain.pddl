
(define (domain delivery-domain)
(:requirements :strips :typing)
(:types package location - object vehicle truck airplane airport - vehicle)
(:predicates
    (at ?v - vehicle ?l - location)
    (free ?v - vehicle)
    (holding ?p - package ?v - vehicle)
    (connected ?l1 - location ?l2 - location)
    (airport ?a - airport)
    (package-at ?p - package ?l - location))

(:action pickup
:parameters (?p - package ?t - truck ?l1 - location ?l2 - location)
:precondition (and (at ?t ?l1) (connected ?l1 ?l2) (package-at ?p ?l2))
:effect (and (not (package-at ?p ?l2)) (holding ?p ?t)))

(:action dropoff
:parameters (?p - package ?t - truck ?l1 - location ?l2 - location)
:precondition (and (at ?t ?l1) (connected ?l1 ?l2) (holding ?p ?t))
:effect (and (not (holding ?p ?t)) (package-at ?p ?l2) (not (at ?t ?l1)) (at ?t ?l2)))

(:action fly
:parameters (?a - airplane ?ap1 - airport ?ap2 - airport)
:precondition (and (at ?a ?ap1) (airport ?ap1) (airport ?ap2))
:effect (and (not (at ?a ?ap1)) (at ?a ?ap2)))

(:action load
:parameters (?p - package ?a - airplane ?ap - airport)
:precondition (and (at ?a ?ap) (airport ?ap) (package-at ?p ?ap) (free ?a))
:effect (and (holding ?p ?a) (not (package-at ?p ?ap)) (not (free ?a))))

(:action unload
:parameters (?p - package ?a - airplane ?ap - airport)
:precondition (and (at ?a ?ap) (airport ?ap) (holding ?p ?a))
:effect (and (not (holding ?p ?a)) (package-at ?p ?ap) (free ?a))))
