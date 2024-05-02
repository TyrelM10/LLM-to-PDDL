
(define (domain delivery-domain)
  ;; types
  (:types location truck package airport plane)
  (:constants
    home-location - location
    home-airport - airport
  )
  (:predicates
    (at ?x - object ?l - location)
    (located-in ?x - object ?l - location)
    (connected ?from - location ?to - location)
    (carrying ?t - truck ?p - package)
    (holding ?p - plane ?pp - package)
    (at-airport ?x - object ?a - airport)
  )
  (:action move-truck
    :parameters (?t - truck ?f - location ?t2 - location ?p - package)
    :precondition (and (at ?t ?f) (connected ?f ?t2) (carrying ?t ?p))
    :effect (and (not (at ?t ?f)) (at ?t ?t2)))
  
  (:action pickup-package
    :parameters (?t - truck ?l - location ?p - package)
    :precondition (and (at ?t ?l) (located-in ?p ?l))
    :effect (carrying ?t ?p))
  
  (:action drop-package
    :parameters (?t - truck ?l - location ?p - package)
    :precondition (and (at ?t ?l) (carrying ?t ?p))
    :effect (and (not (carrying ?t ?p)) (located-in ?p ?l)))
  
  (:action load-plane
    :parameters (?p - plane ?a - airport ?p - package)
    :precondition (and (at-airport ?p ?a))
    :effect (holding ?p ?p))
  
  (:action unload-plane
    :parameters (?p - plane ?a - airport ?p - package)
    :precondition (and (at-airport ?p ?a) (holding ?p ?p))
    :effect (not (holding ?p ?p)) (located-in ?p ?a))
  
  (:action fly-plane
    :parameters (?p - plane ?a1 - airport ?a2 - airport ?p - package)
    :precondition (and (at-airport ?p ?a1) (holding ?p ?p))
    :effect (and (not (at-airport ?p ?a1)) (at-airport ?p ?a2) (not (holding ?p ?p)) (located-in ?p ?a2))))
