
(define (domain logistics)
  (:predicates 
    (at?obj?loc)
    (in-city?loc?city)
    (is-airport?loc)
    (is-truck?veh)
    (is-airplane?veh)
    (in?veh?loc)
  )
  (:action drive
      :parameters (?truck?from?to)
      :precondition (and (is-truck?truck) (in?truck?from) (in-city?from?city) (in-city?to?city))
      :effect (and (not (in?truck?from)) (in?truck?to))
    )
    (:action fly
      :parameters (?airplane?from?to)
      :precondition (and (is-airplane?airplane) (in?airplane?from) (is-airport?from) (is-airport?to))
      :effect (and (not (in?airplane?from)) (in?airplane?to))
    )
    (:action load
      :parameters (?veh?obj?loc)
      :precondition (and (in?veh?loc) (at?obj?loc))
      :effect (not (at?obj?loc))
    )
    (:action unload
      :parameters (?veh?obj?loc)
      :precondition (and (in?veh?loc) (at?obj?loc))
      :effect (at?obj?loc)
    )
)
