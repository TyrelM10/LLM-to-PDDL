(define (problem blocks-world-problem)
  (:domain blocks-world)
  (:objects 
    a b c d
  )
  (:init 
      (on-table a)
      (on-table b)
      (on-table c)
      (clear a)
      (clear b)
      (clear c)
      (hand-empty)
  )
  (:goal 
      (on a b)
      (on b c)
  )
)