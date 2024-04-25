
(define (domain circular_walk)
  (:requirements :strips :typing)

  (:types 
    location day car - object
  )

  (:predicates
    (drive_car ?from ?to - location ?car - car)
    (start_at ?day - day ?location - location)
    (end_at ?day - day ?location - location)
    (walked ?day1 - day ?move - day)
    (have_tent_up ?day - day)  
    (carry_luggage ?car - car)
    (use_car_to_transfer ?car - car)
    (tired)
    (sleeping_bag_in_car ?car - car)
    (partner)
  )
