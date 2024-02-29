
(define (domain blocks-world)
  (:requirements :strips)
  
  (:predicates
    (on ?x ?y)  ; block x is on top of block y
    (ontable ?x)  ; block x is on the table
    (clear ?x)  ; block x is clear
  )
  
  (:action move 
    :parameters (?b ?from ?to)
    :precondition (and 
      (clear ?b)
      (clear ?to)
      (or 
        (ontable ?b) 
        (and 
          (on ?b ?from) 
          (clear ?from) 
        ) 
      ) 
    )
    :effect (and 
      (or 
        (ontable ?b) 
        (and 
          (on ?b ?to) 
          (clear ?from) 
        ) 
      ) 
      (not (clear ?to))
      (not (ontable ?b))
      (clear ?from)
    )
  )
)
