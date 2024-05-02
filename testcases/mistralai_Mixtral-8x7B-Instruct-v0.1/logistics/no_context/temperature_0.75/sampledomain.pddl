
(define (domain delivery-domain)
(:requirements :strips :typing)
(:types location vehicle package - object)
(:predicates
    (location ?x - location)
    (airport ?x - location)
    (city ?x - location)
    (at ?v - vehicle ?l - location)
    (holding ?v - vehicle ?pkg - package)
    (clear ?l - location)
    (free ?v - vehicle)
    (connected ?l1 - location ?l2 - location)
    (has-package ?v - vehicle ?pkg - package)
)

; actions
(:action pickup
    :parameters (?v - vehicle ?l1 - location ?pkg - package)
    :precondition (and (city ?l1) (at ?v ?l1) (clear ?l1) (free ?v) (at ?pkg ?l1))
    :effect (and (not (clear ?l1)) (not (free ?v)) (holding ?v ?pkg) (not (has-package ?v ?pkg)) (not (clear ?v))))

(:action putdown
    :parameters (?v - vehicle ?l2 - location ?pkg - package)
    :precondition (and (airport ?l2) (at ?v ?l2) (holding ?v ?pkg) (clear ?l2) (has-package ?v ?pkg))
    :effect (and (clear ?l2) (not (holding ?v ?pkg)) (at ?pkg ?l2) (not (has-package ?v ?pkg)) (clear ?v)))

(:action move
    :parameters (?v - vehicle ?l1 - location ?l2 - location)
    :precondition (and (city ?l1) (at ?v ?l1) (connected ?l1 ?l2))
    :effect (and (not (at ?v ?l1)) (at ?v ?l2) (clear ?l1) (free ?v)))

(:action fly
    :parameters (?v - vehicle ?l1 - location ?l2 - location)
    :precondition (and (airport ?l1) (at ?v ?l1) (connected ?l1 ?l2))
    :effect (and (not (at ?v ?l1)) (at ?v ?l2)))

(:action load
    :parameters (?v - vehicle ?l1 - location ?pkg - package)
    :precondition (and (at ?v ?l1) (free ?v) (clear ?v) (clear ?l1) (at ?pkg ?l1))
    :effect (and (not (free ?v)) (has-package ?v ?pkg) (not (clear ?l1)) (holding ?v ?pkg)))

(:action unload
    :parameters (?v - vehicle ?l1 - location ?pkg - package)
    :precondition (and (at ?v ?l1) (has-package ?v ?pkg))
    :effect (and (free ?v) (clear ?v) (clear ?l1) (at ?pkg ?l1) (not (has-package ?v ?pkg)) (not (holding ?v ?pkg)))))
