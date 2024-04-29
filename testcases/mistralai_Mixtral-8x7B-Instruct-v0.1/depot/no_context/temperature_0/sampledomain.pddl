
(define (domain truck-hoist)
  (:requirements :strips :typing)
  (:types location crate truck hoist - object)
  (:predicates
    (at ?c - crate ?l - location)
    (on ?x - crate ?y - crate)
    (free ?l - location)
    (holding ?c - crate ?h - hoist)
    (clear ?c - crate))
  (:action pick-up
    :parameters (?c - crate ?h - hoist)
    :precondition (and (at ?c (location-of ?h)) (free (location-of ?h)))
    :effect (and (not (at ?c (location-of ?h)))
                (holding ?c ?h)
                (free (location-of ?h))
                (not (free ?c))))
  (:action put-down
    :parameters (?c - crate ?h - hoist ?l - location)
    :precondition (holding ?c ?h)
    :effect (and (not (holding ?c ?h))
                (at ?c ?l)
                (free ?l)
                (free ?c)))
  (:action lift
    :parameters (?c - crate ?h - hoist)
    :precondition (and (holding ?c ?h) (clear ?c))
    :effect (and (not (clear ?c)) (on ?c nil)))
  (:action lower
    :parameters (?c - crate ?h - hoist)
    :precondition (and (on ?c nil) (holding ?c ?h))
    :effect (and (clear ?c) (not (on ?c nil)) (at ?c (location-of ?h)))
    :postcondition (free ?c)))
