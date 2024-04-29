
(define (domain freecell)
  (:requirements :strips :typing)
  (:types card location number - object)
  
  (:constants 1 2 3 4 - number)
  
  (:predicates
    (empty ?l - location)
    (top-card-of ?c1 - card ?c2 - location)
    (value-greater-than ?c1 - card ?c2 - card)
    (valid-move ?f1 - card ?f2 - location ?t - location)
    (eq-locations ?l1 - location ?l2 - location)
    (eq-cards ?c1 - card ?c2 - card)
    (type-of ?o - object - types)
    (homecard ?c - card - objects)
    (the-freecell ?c - card - number)
    (the-column ?c - card - number)
    (the-destination-for-freecell ?c - card - number))
  
  (:action move-to-freecell
    :parameters (?c - card ?src - location)
    :precondition (and (top-card-of ?c ?src) (empty (destination)))
    :effect (and (not (top-card-of ?c ?src))
                 (not (empty (destination)))
                 (top-card-of ?c (destination))
                 (increase (num-cards-in-homecell ?c) 1)))
  
  (:action move-to-homecell
    :parameters (?c - card ?src - location)
    :precondition (and (empty ?src)
                       (value-greater-than ?c (homecard next-card))
                       (< (+ 1 (value ?c)) (value (homecard next-card))))
    :effect (and (not (top-card-of ?c ?src))
                 (top-card-of ?c (homelocation ?c))
                 (increase (num-cards-in-homecell ?c) 1)))
  
  (:action move-to-column
    :parameters (?c - card ?src - location ?dst - location)
    :precondition (and (empty ?src)
                       (not (top-card-of * ?dst))
                       (<= (- (value (top-card-of * ?dst)) (value ?c)) 1)
                       (< (count) 8))
    :effect (and (not (top-card-of ?c ?src))
                 (top-card-of ?c ?dst)
                 (dec (count))))
  
  (:action create-new-column
    :parameters (?c - card)
    :precondition (and (empty (source ?c))
                       (< (count) 8))
    :effect (and (not (top-card-of ?c (source ?c)))
                 (top-card-of ?c (destination ?c))
                 (add-location (destination ?c))
                 (inc (count)))))
