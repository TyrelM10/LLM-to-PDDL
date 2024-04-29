
(define (domain logistics-blocks)
  (:predicates 
    (at?loc?truck)
    (on-pallet?crate?pallet)
    (on-truck?crate?truck)
    (in?crate?pallet)
    (clear-pallet?pallet)
    (clear-crate?crate)
    (hoist-empty)
    (hoist-holding?crate)
  )
  (:action drive
      :parameters (?truck?loc-from?loc-to)
      :precondition (at?loc-from?truck)
      :effect (and (not (at?loc-from?truck)) (at?loc-to?truck))
    )
    (:action unload
      :parameters (?truck?crate?pallet?loc)
      :precondition (and (at?loc?truck) (on-truck?crate?truck) (clear-pallet?pallet))
      :effect (and (not (on-truck?crate?truck)) (on-pallet?crate?pallet) (not (clear-pallet?pallet)))
    )
    (:action load
      :parameters (?truck?crate?pallet?loc)
      :precondition (and (at?loc?truck) (on-pallet?crate?pallet) (clear-crate?crate))
      :effect (and (not (on-pallet?crate?pallet)) (on-truck?crate?truck) (not (clear-crate?crate)))
    )
    (:action stack
      :parameters (?crate?pallet?loc)
      :precondition (and (on-pallet?crate?pallet) (clear-crate?crate) (hoist-empty))
      :effect (and (in?crate?pallet) (hoist-holding?crate) (not (clear-crate?crate)))
    )
    (:action unstack
      :parameters (?crate?pallet?loc)
      :precondition (and (in?crate?pallet) (hoist-holding?crate))
      :effect (and (on-pallet?crate?pallet) (hoist-empty) (not (hoist-holding?crate)))
    )
)
