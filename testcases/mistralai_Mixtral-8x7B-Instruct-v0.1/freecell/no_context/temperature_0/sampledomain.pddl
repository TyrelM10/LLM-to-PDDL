
(define (domain freecell-game)
  (:requirements :strips :typing)
  (:types card location)
  (:constants
          Spade Heart Diamond Club - suit
          Ace Two Three Four Five Six Seven Eight Nine Ten Jack Queen King - value
          North South East West - location)
  ((at ?c - card ?l - location))
  ((suit ?c - card ?s - suit))
  ((value ?c - card ?v - value))
  ((above ?c1 - card ?c2 - card))
  ((open ?l - location))
  
  ;; Definition of some-location
  (:definition some-location
    (or North South East West))
  
  ;; Predicate to indicate whether a location has no cards
  (:predicate empty (?l - location))
  (:axiom (= (empty North) true))
  (:axiom (= (empty South) true))
  (:axiom (= (empty East) true))
  (:axiom (= (empty West) true))

  ;; Function to determine whether a location contains any cards
  (:function num-cards-at (?l - location) -> num {0})
  (:durative-action increment-num-cards-at
    :parameters (?l - location)
    :duration (= 1)
    :goal (and (>= (num-cards-at ?l) (+ 1 (num-cards-at ?l))) (< (num-cards-at ?l) +inf.0))
    :effect (when (and (<= (num-cards-at ?l) (- +inf.0 1)))
             (at start (num-cards-at ?l) (+ 1 (num-cards-at ?l)))
             (at end (num-cards-at ?l) (+ 1 (num-cards-at ?l))))
    :condition (over all (at t (num-cards-at ?l)) (< (at t (num-cards-at ?l)) +inf.0)))

  ;; Predicate to check if two cards can be placed together based on their suits
  (:predicate compatible-suits (?s1 - suit ?s2 - suit))
  (:axiom (compatible-suits Spade Diamond))
  (:axiom (compatible-suits Heart Club))
  (:axiom (compatible-suits Diamonds Hearts))
  (:axiom (compatible-suits Clubs Spades))

  ;; Predicate to check if two cards have consecutive values
  (:predicate consecutive-values (?val1 - value ?val2 - value))
  (:axiom (consecutive-values Ace Two))
  (:axiom (consecutive-values Two Three))
  (:axiom (consecutive-values Three Four))
  (:axiom (consecutive-values Four Five))
  (:axiom (consecutive-values Five Six))
  (:axiom (consecutive-values Six Seven))
  (:axiom (consecutive-values Seven Eight))
  (:axiom (consecutive-values Eight Nine))
  (:axiom (consecutive-values Nine Ten))
  (:axiom (consecutive-values Ten Jack))
  (:axiom (consecutive-values Jack Queen))
  (:axiom (consecutive-values Queen King))

  ;; Derived predicate to determine if a card can be moved onto another card
  (:derived moving-allowed (?c1 - card ?c2 - card) =>
           (and (exists (?loc - location) (and (at ?c1 ?loc)))
                (exists (?loc - location) (and (at ?c2 ?loc)))
                (not (above ?c1 ?c2))
                (compatible-suits (suit ?c1) (suit ?c2))))

  ;; Action to move a card from one location to another
  (:action move
    :parameters (?src - location ?dst - location ?c - card)
    :precondition (and (at ?c src) (open dst) (empty src) (not (moving-allowed ?c (last dst))))
    :effect (and (not (at ?c src)) (at ?c dst) (increment-num-cards-at dst) (decrement-num-cards-at src))))
