
(define (domain freecell)
  (:requirements :strips :typing)
  (:types card location)
  (:constants 1 2 3 4 5 6 7 8 9 10 J Q K A Waste Tableaus Foundations - location)
  (:constants C1 C2 C3 C4 C5 C6 C7 C8 C9 C10 CJ CQ CK CA - card)
  (:predicates
      (on ?c1 - card ?c2 - card)
      (clear ?c - card)
      (hand-contains ?c - card)
      (faceup ?c - card)
      (nextto ?c1 - card ?c2 - card)
      (suits ?c - card - suit)
      (value ?c - card - integer)
      (destination ?d - location)
      (open ?d - location)
      (full ?d - location)
      (tableau-count ?t - location - count)
      (tableau-empty ?t - location)
      (tableau-stacked ?t - location)
      (tableau-visible ?t - location)
      (waste-empty)
      (location-empty ?l - location)
      (card-in-destination ?cd - card)
      (same-suit ?c1 - card ?c2 - card)
      (ascending-order ?cs - list)
      (descending-order ?cs - list))
  
  ;; Define types for lists of cards
  (:types card-set - (list card+))
  
  ;; Function definition for getting a random top card from a location
  (:function get-top-card (?loc - location) - card
    (if (null ?loc) 
        (error "Empty location")
        (let ((top-card (car ?loc)))
          (if (is-a card top-card)
              top-card
              (get-top-card (cdr loc))))))
  
  ;; Redefined action definitions using either instead of or
  (:action move-card
    :parameters (?src - location ?dst - location ?c - card)
    :precondition (and (either (and (equal src Tableaus) (not (tableau-stacked src))) (and (equal src Waste) (not (waste-empty))))
                       (clear c)
                       (not (full dst))
                       (not (card-in-destination c))
                       (not (equal dst source)))
    :effect (and (when (and (equal src Tableaus) (not (tableau-stacked src))) (not (tableau-stacked src)))
                 (when (and (equal src Waste) (not (waste-empty))) (not (waste-empty)))
                 (not (clear c))
                 (when (equal dst Tableaus) (increase (tableau-count dst) 1))
                 (when (equal dst Foundation) (assert (card-in-destination c)))
                 (move-to dst c)))
  
  (:action deal
    :parameters ()
    :precondition (and (not (tableau-stacked T1)) (not (tableau-stacked T2)) (not (tableau-stacked T3)) (not (tableau-stacked T4)) (not (tableau-visible T1)) (not (tableau-visible T2)) (not (tableau-visible T3)) (not (tableau-visible T4)) (waste-empty) (not (location-empty Waste)))
    :effect (and (decrement counter)
                 (exists (?new-card - card)
                         (and (= new-card (get-top-card Waste))
                              (move-to Waste new-card)
                              (not (waste-empty))))))
  
  ;; Add other actions such as moving cards within tableaus, from waste to tableaus, etc.
  )
