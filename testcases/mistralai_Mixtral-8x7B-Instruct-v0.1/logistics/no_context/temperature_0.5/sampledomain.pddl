 (define (domain delivery)
(:requirements :strips :typing)
(:types location vehicle package - object)
(:constants +home+ +cityA+ +cityB+ +airportA+ +airportB+ - location)
(:predicates
(at ?v - vehicle ?l - location)
(location-city ?l1 - location ?l2 - location)
(airport ?a - location)
(loaded ?v - vehicle ?p - package)
(unloaded ?p - package))

(:action load-truck
:parameters (?t - vehicle ?p - package ?l1 - location ?l2 - location)
:precondition (and (at ?t ?l1) (unloaded ?p) (at ?p ?l1) (location-city ?l1 ?l2))
:effect (and (not (at ?p ?l1)) (loaded ?t ?p) (not (at ?t ?l1)) (at ?t ?l2) (unloaded ?p)))

(:action unload-truck
:parameters (?t - vehicle ?p - package ?l1 - location ?l2 - location)
:precondition (and (at ?t ?l1) (loaded ?t ?p) (location-city ?l1 ?l2))
:effect (and (at ?p ?l2) (not (loaded ?t ?p)) (at ?t ?l2) (unloaded ?p)))

(:action load-plane
:parameters (?p - vehicle ?ap1 - location ?pac - package ?ap2 - location)
:precondition (and (at ?p ?ap1) (unloaded ?pac) (at ?pac ?ap1) (airport ?ap1) (airport ?ap2))
:effect (and (not (at ?pac ?ap1)) (loaded ?p ?pac) (not (at ?p ?ap1)) (at ?p ?ap2) (unloaded ?pac)))

(:action unload-plane
:parameters (?p - vehicle ?ap1 - location ?pac - package ?ap2 - location)
:precondition (and (at ?p ?ap1) (loaded ?p ?pac) (at ?pac ?ap1) (airport ?ap1) (airport ?ap2))
:effect (and (at ?pac ?ap2) (not (loaded ?p ?pac)) (at ?p ?ap2) (unloaded ?pac))))