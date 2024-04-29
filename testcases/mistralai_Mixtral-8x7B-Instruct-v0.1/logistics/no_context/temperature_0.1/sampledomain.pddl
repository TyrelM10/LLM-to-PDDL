 (define (domain delivery)
(:requirements :strips)
(:types location truck package - object airport - location)
(:predicates
(at ?l - location ?loc - location)
(has-package ?x - vehicle ?pkg - package)
(destination ?pkg - package ?dest - location)
(connected ?fromLoc - location ?toLoc - location)
(free-space-in ?v - vehicle)
(at-airport ?p - package ?ap - airport)
(arrived-at ?pkg - package))
(:constants HomeCity Airport1 Airport2 Airport3 Truck1 Plane1 Package1 Package2)

(:action load-truck
:parameters (?t - truck ?loc - location ?pkg - package)
:precondition (and (at ?t ?loc) (not (has-package ?t ?pkg)))
:effect (and (not (at ?t ?loc)) (not (at ?pkg ?loc))
(not (destination ?pkg ?loc)) (has-package ?t ?pkg)))

(:action unload-truck
:parameters (?t - truck ?loc - location ?pkg - package)
:precondition (and (at ?t ?loc) (has-package ?t ?pkg))
:effect (and (at ?t ?loc) (at ?pkg ?loc)
(destination ?pkg ?loc) (not (has-package ?t ?pkg))))

(:action move-truck
:parameters (?t - truck ?fromLoc - location ?toLoc - location)
:precondition (and (at ?t ?fromLoc) (connected ?fromLoc ?toLoc))
:effect (and (not (at ?t ?fromLoc)) (at ?t ?toLoc)))

(:action pickup-package
:parameters (?t - truck ?pkg - package)
:precondition (and (at (location-of ?pkg) (location-of ?t)) (has-package nil ?pkg))
:effect (and (not (has-package nil ?pkg)) (has-package ?t ?pkg)))

(:action deliver-package
:parameters (?t - truck ?pkg - package)
:precondition (and (at (location-of ?pkg) (location-of ?t)) (has-package ?t ?pkg) (arrived-at ?pkg))
:effect (and (not (has-package ?t ?pkg)) (not (has-package nil ?pkg))))

(:action enter-vehicle
:parameters (?p - package ?v - vehicle)
:precondition (and (not (has-package ?v ?p)) (free-space-in ?v))
:effect (and (has-package ?v ?p) (not (has-package nil ?p))))

(:action leave-vehicle
:parameters (?p - package ?v - vehicle)
:precondition (has-package ?v ?p)
:effect (and (not (has-package ?v ?p)) (has-package nil ?p)))

(:action fly-plane
:parameters (?p - package ?apFrom - airport ?apTo - airport)
:precondition (and (at-airport ?p ?apFrom))
:effect (and (not (at-airport ?p ?apFrom)) (at-airport ?p ?apTo))))