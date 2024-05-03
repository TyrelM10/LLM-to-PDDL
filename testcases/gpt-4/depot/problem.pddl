(define (problem logistics-blocks-problem)
  (:domain combined-logistics-blocks)
  (:objects
    crate1 crate2 - crate
    pallet1 pallet2 - pallet
    truck1 - truck
    hoist1 - hoist
    loc1 loc2 - location
  )

  (:init
    (at-crate crate1 loc1)
    (at-crate crate2 loc1)
    (at-truck truck1 loc1)
    (at-hoist hoist1 loc2)
    (empty-truck truck1)
    (empty-hoist hoist1)
    (empty-pallet pallet1)
    (empty-pallet pallet2)
  )

  (:goal
    (and
      (on-pallet crate1 pallet1)
      (on-pallet crate2 pallet2)
      (at-hoist hoist1 loc2)
      (at-truck truck1 loc2)
    )
  )
)