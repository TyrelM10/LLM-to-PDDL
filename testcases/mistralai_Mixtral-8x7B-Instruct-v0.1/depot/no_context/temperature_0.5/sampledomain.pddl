
(define (domain truck_and_hoist)
  (:requirements :strips :typing)

  (:types location hoist truck pallet crate vehicle)

  (:constants some-location)

  (:predicates
    (on ?c - crate ?pl - pallet)
    (clear ?pl - pallet)
    (holding ?h - hoist ?c - crate)
    (at ?v - vehicle ?l - location))

  (:action pickup
    :parameters (?h - hoist ?c - crate ?pl - pallet)
    :precondition (and (clear ?pl) (on ?c ?pl) (at ?h ?pl))
    :effect (and (not (on ?c ?pl)) (not (clear ?pl)) (holding ?h ?c) (not (at ?h ?pl)) (at ?h some-location)))

  (:action putdown
    :parameters (?h - hoist ?c - crate ?pl - pallet)
    :precondition (holding ?h ?c)
    :effect (and (on ?c ?pl) (clear ?pl) (not (holding ?h ?c)) (at ?h some-location) (at ?h ?pl)))

  (:action load
    :parameters (?t - truck ?c - crate)
    :precondition (and (at ?t some-location) (clear some-location))
    :effect (and (on ?c ?t) (not (on ?c some-location)) (not (clear some-location))))

  (:action unload
    :parameters (?t - truck ?c - crate)
    :precondition (and (at ?t some-location) (on ?c ?t))
    :effect (and (on ?c some-location) (clear some-location) (not (on ?c ?t))))

  (:action move
    :parameters (?v - vehicle ?fl - location ?tl - location)
    :precondition (at ?v ?fl)
    :effect (and (not (at ?v ?fl)) (at ?v ?tl))))
