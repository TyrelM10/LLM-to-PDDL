**USER** :
This domain was devised in order to see what would happen if two previously well-researched domains were joined together. These were the logistics and blocks domains. They are combined to form a domain in which trucks can transport crates around and then the crates must be stacked onto pallets at their destinations. The stacking is achieved using hoists, so the stacking problem is like a blocks-world problem with hands. Trucks can behave like "tables", since the pallets on which crates are stacked are limited.
 
 Instruction: Generate PDDL domain code for the above text description in code blocks delimited only between ```pddl <CODE></CODE> ```. This code should be solved in a STRIPS Planner. Do not give any explanations in the output.
**LLM MODEL** (HUGGING_FACE):
```pddl 

(define (domain logistics-blocks-world)
  (:requirements :strips :typing)
  
  ;; Define types of objects
  (:types truck crate pallet hoist location)
  
  ;; Define predicates
  (:predicate (location ?x - object)
              (clear ?x - object)
              (holding ?x - object)
              (on ?x - crate ?y - crate)
              (ontop ?x - crate ?y - pallet)
              (at-location ?t - truck ?l - location))
  
  ;; Define action schemas
  (:action pick-up-crate
    :parameters (?c - crate ?h - hoist ?l1 - location ?l2 - location)
    :precondition (and (clear ?c) (clear ?h) (at-location ?h ?l1) (ontop ?c nil) (location ?c ?l2))
    :effect (and (not (location ?c ?l2)) (not (ontop ?c nil)) (not (clear ?h)) (not (clear ?c)))
            (and (holding ?c) (on ?c ?h) (at-location ?h ?l1))))
  
  (:action put-down-crate
    :parameters (?c - crate ?h - hoist ?l1 - location ?l2 - location)
    :precondition (and (holding ?c) (on ?c ?h) (at-location ?h ?l1))
    :effect (and (not (holding ?c)) (not (on ?c ?h)) (not (at-location ?h ?l1)) (clear ?h) (clear ?c))
             (and (location ?c ?l2) (ontop ?c nil) (at-location ?h ?l2))))
  
  (:action move-truck
    :parameters (?t - truck ?from - location ?to - location)
    :precondition (and (at-location ?t ?from))
    :effect (and (not (at-location ?t ?from)) (at-location ?t ?to))))
  
  (:action load-crane
    :parameters (?t - truck ?c - crate ?h - hoist)
    :precondition (and (at-location ?t ?h) (clear ?h) (clear ?c) (ontop ?c nil))
    :effect (and (holding ?c) (not (ontop ?c nil)) (not (clear ?c)) (not (clear ?h)) (on ?c ?h))))
  
  (:action unload-crane
    :parameters (?t - truck ?c - crate ?h - hoist)
    :precondition (and (at-location ?t ?h) (holding ?c) (on ?c ?h))
    :effect (and (not (holding ?c)) (not (on ?c ?h)) (clear ?h) (clear ?c) (ontop ?c nil) (at-location ?c ?h))))
  
  (:action stack-crates
    :parameters (?c1 - crate ?c2 - crate ?h - hoist)
    :precondition (and (holding ?c1) (clear ?c2) (clear ?h) (ontop ?c2 nil))
    :effect (and (not (holding ?c1)) (not (ontop ?c2 nil)) (on ?c1 ?c2) (clear ?h) (clear ?c1))))
  
  (:action unstack-crates
    :parameters (?c1 - crate ?c2 - crate ?h - hoist)
    :precondition (and (holding ?c1) (on ?c1 ?c2))
    :effect (and (not (holding ?c1)) (not (on ?c1 ?c2)) (clear ?c1) (ontop ?c2 nil) (clear ?h))))

```
**USER** :
```pddl

(define (domain logistics-blocks-world)
  (:requirements :strips :typing)
  
  ;; Define types of objects
  (:types truck crate pallet hoist location)
  
  ;; Define predicates
  (:predicate (location ?x - object)
              (clear ?x - object)
              (holding ?x - object)
              (on ?x - crate ?y - crate)
              (ontop ?x - crate ?y - pallet)
              (at-location ?t - truck ?l - location))
  
  ;; Define action schemas
  (:action pick-up-crate
    :parameters (?c - crate ?h - hoist ?l1 - location ?l2 - location)
    :precondition (and (clear ?c) (clear ?h) (at-location ?h ?l1) (ontop ?c nil) (location ?c ?l2))
    :effect (and (not (location ?c ?l2)) (not (ontop ?c nil)) (not (clear ?h)) (not (clear ?c)))
            (and (holding ?c) (on ?c ?h) (at-location ?h ?l1))))
  
  (:action put-down-crate
    :parameters (?c - crate ?h - hoist ?l1 - location ?l2 - location)
    :precondition (and (holding ?c) (on ?c ?h) (at-location ?h ?l1))
    :effect (and (not (holding ?c)) (not (on ?c ?h)) (not (at-location ?h ?l1)) (clear ?h) (clear ?c))
             (and (location ?c ?l2) (ontop ?c nil) (at-location ?h ?l2))))
  
  (:action move-truck
    :parameters (?t - truck ?from - location ?to - location)
    :precondition (and (at-location ?t ?from))
    :effect (and (not (at-location ?t ?from)) (at-location ?t ?to))))
  
  (:action load-crane
    :parameters (?t - truck ?c - crate ?h - hoist)
    :precondition (and (at-location ?t ?h) (clear ?h) (clear ?c) (ontop ?c nil))
    :effect (and (holding ?c) (not (ontop ?c nil)) (not (clear ?c)) (not (clear ?h)) (on ?c ?h))))
  
  (:action unload-crane
    :parameters (?t - truck ?c - crate ?h - hoist)
    :precondition (and (at-location ?t ?h) (holding ?c) (on ?c ?h))
    :effect (and (not (holding ?c)) (not (on ?c ?h)) (clear ?h) (clear ?c) (ontop ?c nil) (at-location ?c ?h))))
  
  (:action stack-crates
    :parameters (?c1 - crate ?c2 - crate ?h - hoist)
    :precondition (and (holding ?c1) (clear ?c2) (clear ?h) (ontop ?c2 nil))
    :effect (and (not (holding ?c1)) (not (ontop ?c2 nil)) (on ?c1 ?c2) (clear ?h) (clear ?c1))))
  
  (:action unstack-crates
    :parameters (?c1 - crate ?c2 - crate ?h - hoist)
    :precondition (and (holding ?c1) (on ?c1 ?c2))
    :effect (and (not (holding ?c1)) (not (on ?c1 ?c2)) (clear ?c1) (ontop ?c2 nil) (clear ?h))))

```

The above code produces the following error -> There was an error in parsing the code. Got unexpected token: (. The parenthesis is opened in the wrong position in the code. Please check the parenthesis.

Instruction 1: Correct the error and give the entire PDDL code in code blocks and please do not give any explanations in the output.
Instruction 2: Do not create a problem file and do not use conditional expressions.
**LLM MODEL** (HUGGING_FACE):
```pddl 

(define (domain logistics-blocks-world)
  (:requirements :strips :typing)
  
  ;; Define types of objects
  (:types truck crate pallet hoist location)
  
  ;; Define predicates
  (:predicate (location ?x - object)
              (clear ?x - object)
              (holding ?x - object)
              (on ?x - crate ?y - crate)
              (ontop ?x - crate ?y - pallet)
              (at-location ?t - truck ?l - location))
  
  ;; Define action schemas
  (:action pick-up-crate
    :parameters (?c - crate ?h - hoist ?l1 - location ?l2 - location)
    :precondition (and (clear ?c) (clear ?h) (at-location ?h l1) (ontop ?c nil) (location ?c l2))
    :effect (and (not (location ?c l2)) (not (ontop ?c nil)) (not (clear ?h)) (not (clear ?c))
                (holding ?c) (on ?c ?h) (at-location ?h l1)))
  
  (:action put-down-crate
    :parameters (?c - crate ?h - hoist ?l1 - location ?l2 - location)
    :precondition (and (holding ?c) (on ?c ?h) (at-location ?h l1))
    :effect (and (not (holding ?c)) (not (on ?c ?h)) (not (at-location ?h l1)) (clear ?h) (clear ?c)
                (location ?c l2) (ontop ?c nil) (at-location ?h l2)))
  
  (:action move-truck
    :parameters (?t - truck ?from - location ?to - location)
    :precondition (and (at-location ?t from))
    :effect (and (not (at-location ?t from)) (at-location ?t to)))
  
  (:action load-crane
    :parameters (?t - truck ?c - crate ?h - hoist)
    :precondition (and (at-location t h) (clear h) (clear c) (ontop c nil))
    :effect (and (holding c) (not (ontop c nil)) (not (clear c)) (not (clear h)) (on c h)))
  
  (:action unload-crane
    :parameters (?t - truck ?c - crate ?h - hoist)
    :precondition (and (at-location t h) (holding c) (on c h))
    :effect (and (not (holding c)) (not (on c h)) (clear h) (clear c) (ontop c nil) (at-location c h)))
  
  (:action stack-crates
    :parameters (?c1 - crate ?c2 - crate ?h - hoist)
    :precondition (and (holding c1) (clear c2) (clear h) (ontop c2 nil))
    :effect (and (not (holding c1)) (not (ontop c2 nil)) (on c1 c2) (clear h) (clear c1)))
  
  (:action unstack-crates
    :parameters (?c1 - crate ?c2 - crate ?h - hoist)
    :precondition (and (holding c1) (on c1 c2))
    :effect (and (not (holding c1)) (not (on c1 c2)) (clear c1) (ontop c2 nil) (clear h))))

```
**USER** :
```pddl

(define (domain logistics-blocks-world)
  (:requirements :strips :typing)
  
  ;; Define types of objects
  (:types truck crate pallet hoist location)
  
  ;; Define predicates
  (:predicate (location ?x - object)
              (clear ?x - object)
              (holding ?x - object)
              (on ?x - crate ?y - crate)
              (ontop ?x - crate ?y - pallet)
              (at-location ?t - truck ?l - location))
  
  ;; Define action schemas
  (:action pick-up-crate
    :parameters (?c - crate ?h - hoist ?l1 - location ?l2 - location)
    :precondition (and (clear ?c) (clear ?h) (at-location ?h l1) (ontop ?c nil) (location ?c l2))
    :effect (and (not (location ?c l2)) (not (ontop ?c nil)) (not (clear ?h)) (not (clear ?c))
                (holding ?c) (on ?c ?h) (at-location ?h l1)))
  
  (:action put-down-crate
    :parameters (?c - crate ?h - hoist ?l1 - location ?l2 - location)
    :precondition (and (holding ?c) (on ?c ?h) (at-location ?h l1))
    :effect (and (not (holding ?c)) (not (on ?c ?h)) (not (at-location ?h l1)) (clear ?h) (clear ?c)
                (location ?c l2) (ontop ?c nil) (at-location ?h l2)))
  
  (:action move-truck
    :parameters (?t - truck ?from - location ?to - location)
    :precondition (and (at-location ?t from))
    :effect (and (not (at-location ?t from)) (at-location ?t to)))
  
  (:action load-crane
    :parameters (?t - truck ?c - crate ?h - hoist)
    :precondition (and (at-location t h) (clear h) (clear c) (ontop c nil))
    :effect (and (holding c) (not (ontop c nil)) (not (clear c)) (not (clear h)) (on c h)))
  
  (:action unload-crane
    :parameters (?t - truck ?c - crate ?h - hoist)
    :precondition (and (at-location t h) (holding c) (on c h))
    :effect (and (not (holding c)) (not (on c h)) (clear h) (clear c) (ontop c nil) (at-location c h)))
  
  (:action stack-crates
    :parameters (?c1 - crate ?c2 - crate ?h - hoist)
    :precondition (and (holding c1) (clear c2) (clear h) (ontop c2 nil))
    :effect (and (not (holding c1)) (not (ontop c2 nil)) (on c1 c2) (clear h) (clear c1)))
  
  (:action unstack-crates
    :parameters (?c1 - crate ?c2 - crate ?h - hoist)
    :precondition (and (holding c1) (on c1 c2))
    :effect (and (not (holding c1)) (not (on c1 c2)) (clear c1) (ontop c2 nil) (clear h))))

```

The above code produces the following error -> There is a value error on finding unknown keyword in domain definition: 'predicate'. Valid keyword representations in definition are ':requirements', ':types', ':predicates', ':constants' and ':action'. Remove the unknown keyword 'predicate' from definition and update the code.

Instruction 1: Correct the error and give the entire PDDL code in code blocks and please do not give any explanations in the output.
Instruction 2: Do not create a problem file and do not use conditional expressions.
**LLM MODEL** (HUGGING_FACE):
```pddl 

(define (domain logistics-blocks-world)
  (:requirements :strips :typing)

  ;; Define types of objects
  (:types truck crate pallet hoist location)

  ;; Define predicates
  (:predicates
    (location ?x - object)
    (clear ?x - object)
    (holding ?x - object)
    (on ?x - crate ?y - crate)
    (ontop ?x - crate ?y - pallet)
    (at-location ?t - truck ?l - location))

  ;; Define action schemas
  (:action pick-up-crate
    :parameters (?c - crate ?h - hoist ?l1 - location ?l2 - location)
    :precondition (and (clear ?c) (clear ?h) (at-location ?h l1) (ontop ?c nil) (location ?c l2))
    :effect (and (not (location ?c l2)) (not (ontop ?c nil)) (not (clear ?h)) (not (clear ?c))
                (holding ?c) (on ?c ?h) (at-location ?h l1)))

  (:action put-down-crate
    :parameters (?c - crate ?h - hoist ?l1 - location ?l2 - location)
    :precondition (and (holding ?c) (on ?c ?h) (at-location ?h l1))
    :effect (and (not (holding ?c)) (not (on ?c ?h)) (not (at-location ?h l1)) (clear ?h) (clear ?c)
                (location ?c l2) (ontop ?c nil) (at-location ?h l2)))

  (:action move-truck
    :parameters (?t - truck ?from - location ?to - location)
    :precondition (and (at-location ?t from))
    :effect (and (not (at-location ?t from)) (at-location ?t to)))

  (:action load-crane
    :parameters (?t - truck ?c - crate ?h - hoist)
    :precondition (and (at-location t h) (clear h) (clear c) (ontop c nil))
    :effect (and (holding c) (not (ontop c nil)) (not (clear c)) (not (clear h)) (on c h)))

  (:action unload-crane
    :parameters (?t - truck ?c - crate ?h - hoist)
    :precondition (and (at-location t h) (holding c) (on c h))
    :effect (and (not (holding c)) (not (on c h)) (clear h) (clear c) (ontop c nil) (at-location c h)))

  (:action stack-crates
    :parameters (?c1 - crate ?c2 - crate ?h - hoist)
    :precondition (and (holding c1) (clear c2) (clear h) (ontop c2 nil))
    :effect (and (not (holding c1)) (not (ontop c2 nil)) (on c1 c2) (clear h) (clear c1)))

  (:action unstack-crates
    :parameters (?c1 - crate ?c2 - crate ?h - hoist)
    :precondition (and (holding c1) (on c1 c2))
    :effect (and (not (holding c1)) (not (on c1 c2)) (clear c1) (ontop c2 nil) (clear h))))

```
**USER** :
```pddl

(define (domain logistics-blocks-world)
  (:requirements :strips :typing)

  ;; Define types of objects
  (:types truck crate pallet hoist location)

  ;; Define predicates
  (:predicates
    (location ?x - object)
    (clear ?x - object)
    (holding ?x - object)
    (on ?x - crate ?y - crate)
    (ontop ?x - crate ?y - pallet)
    (at-location ?t - truck ?l - location))

  ;; Define action schemas
  (:action pick-up-crate
    :parameters (?c - crate ?h - hoist ?l1 - location ?l2 - location)
    :precondition (and (clear ?c) (clear ?h) (at-location ?h l1) (ontop ?c nil) (location ?c l2))
    :effect (and (not (location ?c l2)) (not (ontop ?c nil)) (not (clear ?h)) (not (clear ?c))
                (holding ?c) (on ?c ?h) (at-location ?h l1)))

  (:action put-down-crate
    :parameters (?c - crate ?h - hoist ?l1 - location ?l2 - location)
    :precondition (and (holding ?c) (on ?c ?h) (at-location ?h l1))
    :effect (and (not (holding ?c)) (not (on ?c ?h)) (not (at-location ?h l1)) (clear ?h) (clear ?c)
                (location ?c l2) (ontop ?c nil) (at-location ?h l2)))

  (:action move-truck
    :parameters (?t - truck ?from - location ?to - location)
    :precondition (and (at-location ?t from))
    :effect (and (not (at-location ?t from)) (at-location ?t to)))

  (:action load-crane
    :parameters (?t - truck ?c - crate ?h - hoist)
    :precondition (and (at-location t h) (clear h) (clear c) (ontop c nil))
    :effect (and (holding c) (not (ontop c nil)) (not (clear c)) (not (clear h)) (on c h)))

  (:action unload-crane
    :parameters (?t - truck ?c - crate ?h - hoist)
    :precondition (and (at-location t h) (holding c) (on c h))
    :effect (and (not (holding c)) (not (on c h)) (clear h) (clear c) (ontop c nil) (at-location c h)))

  (:action stack-crates
    :parameters (?c1 - crate ?c2 - crate ?h - hoist)
    :precondition (and (holding c1) (clear c2) (clear h) (ontop c2 nil))
    :effect (and (not (holding c1)) (not (ontop c2 nil)) (on c1 c2) (clear h) (clear c1)))

  (:action unstack-crates
    :parameters (?c1 - crate ?c2 - crate ?h - hoist)
    :precondition (and (holding c1) (on c1 c2))
    :effect (and (not (holding c1)) (not (on c1 c2)) (clear c1) (ontop c2 nil) (clear h))))

```

The above code produces the following error -> There is a semantic error where there are wrong number of arguments for predicate 'location' in precondition of action 'pick-up-crate'.

Instruction 1: Correct the error and give the entire PDDL code in code blocks and please do not give any explanations in the output.
Instruction 2: Do not create a problem file and do not use conditional expressions.
**LLM MODEL** (HUGGING_FACE):
```pddl 

(define (domain logistics-blocks-world)
  (:requirements :strips :typing)
  
  ;; Define types of objects
  (:types truck crate pallet hoist location)
  
  ;; Define predicates
  (:predicates
    (location ?x - object ?l - location)
    (clear ?x - object)
    (holding ?x - object)
    (on ?x - crate ?y - crate)
    (ontop ?x - crate ?y - pallet)
    (at-location ?t - truck ?l - location))
  
  ;; Define action schemas
  (:action pick-up-crate
    :parameters (?c - crate ?h - hoist ?l1 - location ?l2 - location)
    :precondition (and (location ?c l1) (clear ?c) (at-location ?h l1) (ontop ?c nil))
    :effect (and (not (location ?c l1)) (not (ontop ?c nil)) (not (clear ?c)) (not (at-location ?h l1))
                (holding ?c) (on ?c ?h) (location ?c l2) (at-location ?h l1)))
  
  (:action put-down-crate
    :parameters (?c - crate ?h - hoist ?l1 - location ?l2 - location)
    :precondition (and (holding ?c) (on ?c ?h) (at-location ?h l1) (location ?c l2))
    :effect (and (not (holding ?c)) (not (on ?c ?h)) (clear ?h) (clear ?c)
                (ontop ?c nil) (location ?c l2) (at-location ?h l2)))
  
  (:action move-truck
    :parameters (?t - truck ?from - location ?to - location)
    :precondition (and (at-location ?t from))
    :effect (and (not (at-location ?t from)) (at-location ?t to)))
  
  (:action load-crane
    :parameters (?t - truck ?c - crate ?h - hoist)
    :precondition (and (at-location t h) (clear h) (clear c) (ontop c nil))
    :effect (and (holding c) (not (ontop c nil)) (not (clear c)) (not (clear h)) (on c h)))
  
  (:action unload-crane
    :parameters (?t - truck ?c - crate ?h - hoist)
    :precondition (and (at-location t h) (holding c) (on c h))
    :effect (and (not (holding c)) (not (on c h)) (clear h) (clear c) (ontop c nil) (at-location c h)))
  
  (:action stack-crates
    :parameters (?c1 - crate ?c2 - crate ?h - hoist)
    :precondition (and (holding c1) (clear c2) (clear h) (ontop c2 nil))
    :effect (and (not (holding c1)) (not (ontop c2 nil)) (on c1 c2) (clear h) (clear c1)))
  
  (:action unstack-crates
    :parameters (?c1 - crate ?c2 - crate ?h - hoist)
    :precondition (and (holding c1) (on c1 c2))
    :effect (and (not (holding c1)) (not (on c1 c2)) (clear c1) (ontop c2 nil) (clear h))))

```