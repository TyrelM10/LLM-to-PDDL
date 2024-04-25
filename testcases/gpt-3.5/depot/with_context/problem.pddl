(define (problem logistics-blocks-problem)
  (:domain logistics-blocks)
  (:objects 
    truck1 truck2 - truck
    crate1 crate2 - crate
    pallet1 pallet2 - pallet
    location1 location2 - object
  )
  (:init
    (at truck1 location1)
    (at truck2 location2)
    (at crate1 location1)
    (at crate2 location2)
    (empty truck1)
    (empty truck2)
    (hoist-empty)
    (clear pallet1)
    (clear pallet2)
  )
  (:goal
    (and 
      (on crate1 pallet1)
      (on crate2 pallet2)
    )
  )
)
