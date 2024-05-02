**USER** :
There are several cities, each containing several locations, some of which are airports. There are also trucks, which can drive within a single city, and airplanes, which can fly between airports. The goal is to get some packages from various locations to various new locations. This domain was created by Bart Selman and Henry Kautz, based on an earlier domain by Manuela Veloso.
 
 Instruction: Generate PDDL domain code for the above text description in code blocks delimited only between ```pddl <CODE></CODE> ```. This code should be solved in a STRIPS Planner. Do not give any explanations in the output.
**LLM MODEL** (HUGGING_FACE):
```pddl 

(define (domain delivery-domain)
(:requirements :strips :typing)
(:types package location truck airport - vehicle)
(:predicates
    (at ?v - vehicle ?l - location)
    (free ?v - vehicle)
    (holding ?p - package ?v - vehicle)
    (connected ?l1 - location ?l2 - location)
)

(:action pickup
    :parameters (?p - package ?t - truck ?l1 - location ?l2 - location)
    :precondition (and (at ?t ?l1) (connected ?l1 ?l2) (at-package ?p ?l2))
    :effect (and (not (at-package ?p ?l2)) (holding ?p ?t)))

(:action dropoff
    :parameters (?p - package ?t - truck ?l1 - location ?l2 - location)
    :precondition (and (at ?t ?l1) (connected ?l1 ?l2) (holding ?p ?t))
    :effect (and (not (holding ?p ?t)) (at-package ?p ?l2) (not (at ?t ?l1)) (at ?t ?l2)))

(:action fly
    :parameters (?a - airplane ?ap1 - airport ?ap2 - airport)
    :precondition (and (at ?a ?ap1) (airport ?ap1) (airport ?ap2))
    :effect (and (not (at ?a ?ap1)) (at ?a ?ap2)))

(:action load
    :parameters (?p - package ?a - airplane ?ap - airport)
    :precondition (and (at ?a ?ap) (airport ?ap) (at-package ?p ?ap) (free ?a))
    :effect (and (holding ?p ?a) (not (at-package ?p ?ap)) (not (free ?a))))

(:action unload
    :parameters (?p - package ?a - airplane ?ap - airport)
    :precondition (and (at ?a ?ap) (airport ?ap) (holding ?p ?a))
    :effect (and (not (holding ?p ?a)) (at-package ?p ?ap) (free ?a))))

```
**USER** :
```pddl

(define (domain delivery-domain)
(:requirements :strips :typing)
(:types package location truck airport - vehicle)
(:predicates
    (at ?v - vehicle ?l - location)
    (free ?v - vehicle)
    (holding ?p - package ?v - vehicle)
    (connected ?l1 - location ?l2 - location)
)

(:action pickup
    :parameters (?p - package ?t - truck ?l1 - location ?l2 - location)
    :precondition (and (at ?t ?l1) (connected ?l1 ?l2) (at-package ?p ?l2))
    :effect (and (not (at-package ?p ?l2)) (holding ?p ?t)))

(:action dropoff
    :parameters (?p - package ?t - truck ?l1 - location ?l2 - location)
    :precondition (and (at ?t ?l1) (connected ?l1 ?l2) (holding ?p ?t))
    :effect (and (not (holding ?p ?t)) (at-package ?p ?l2) (not (at ?t ?l1)) (at ?t ?l2)))

(:action fly
    :parameters (?a - airplane ?ap1 - airport ?ap2 - airport)
    :precondition (and (at ?a ?ap1) (airport ?ap1) (airport ?ap2))
    :effect (and (not (at ?a ?ap1)) (at ?a ?ap2)))

(:action load
    :parameters (?p - package ?a - airplane ?ap - airport)
    :precondition (and (at ?a ?ap) (airport ?ap) (at-package ?p ?ap) (free ?a))
    :effect (and (holding ?p ?a) (not (at-package ?p ?ap)) (not (free ?a))))

(:action unload
    :parameters (?p - package ?a - airplane ?ap - airport)
    :precondition (and (at ?a ?ap) (airport ?ap) (holding ?p ?a))
    :effect (and (not (holding ?p ?a)) (at-package ?p ?ap) (free ?a))))

```

The above code produces the following error -> There is a semantic error of unknown parent type: vehicle

Instruction 1: Correct the error and give the entire PDDL code in code blocks and please do not give any explanations in the output.
Instruction 2: Do not create a problem file and do not use conditional expressions.
**LLM MODEL** (HUGGING_FACE):
```pddl 

(define (domain delivery-domain)
  (:requirements :strips :typing)
  (:types package location - object vehicle truck airplane airport - vehicle)
  (:predicates
    (at ?v - vehicle ?l - location)
    (free ?v - vehicle)
    (holding ?p - package ?v - vehicle)
    (connected ?l1 - location ?l2 - location)
    (airport ?a - airport))
  
  (:action pickup
    :parameters (?p - package ?t - truck ?l1 - location ?l2 - location)
    :precondition (and (at ?t ?l1) (connected ?l1 ?l2) (at-package ?p ?l2))
    :effect (and (not (at-package ?p ?l2)) (holding ?p ?t)))

  (:action dropoff
    :parameters (?p - package ?t - truck ?l1 - location ?l2 - location)
    :precondition (and (at ?t ?l1) (connected ?l1 ?l2) (holding ?p ?t))
    :effect (and (not (holding ?p ?t)) (at-package ?p ?l2) (not (at ?t ?l1)) (at ?t ?l2)))

  (:action fly
    :parameters (?a - airplane ?ap1 - airport ?ap2 - airport)
    :precondition (and (at ?a ?ap1) (airport ?ap1) (airport ?ap2))
    :effect (and (not (at ?a ?ap1)) (at ?a ?ap2)))

  (:action load
    :parameters (?p - package ?a - airplane ?ap - airport)
    :precondition (and (at ?a ?ap) (airport ?ap) (at-package ?p ?ap) (free ?a))
    :effect (and (holding ?p ?a) (not (at-package ?p ?ap)) (not (free ?a))))

  (:action unload
    :parameters (?p - package ?a - airplane ?ap - airport)
    :precondition (and (at ?a ?ap) (airport ?ap) (holding ?p ?a))
    :effect (and (not (holding ?p ?a)) (at-package ?p ?ap) (free ?a))))

```
**USER** :
```pddl

(define (domain delivery-domain)
  (:requirements :strips :typing)
  (:types package location - object vehicle truck airplane airport - vehicle)
  (:predicates
    (at ?v - vehicle ?l - location)
    (free ?v - vehicle)
    (holding ?p - package ?v - vehicle)
    (connected ?l1 - location ?l2 - location)
    (airport ?a - airport))
  
  (:action pickup
    :parameters (?p - package ?t - truck ?l1 - location ?l2 - location)
    :precondition (and (at ?t ?l1) (connected ?l1 ?l2) (at-package ?p ?l2))
    :effect (and (not (at-package ?p ?l2)) (holding ?p ?t)))

  (:action dropoff
    :parameters (?p - package ?t - truck ?l1 - location ?l2 - location)
    :precondition (and (at ?t ?l1) (connected ?l1 ?l2) (holding ?p ?t))
    :effect (and (not (holding ?p ?t)) (at-package ?p ?l2) (not (at ?t ?l1)) (at ?t ?l2)))

  (:action fly
    :parameters (?a - airplane ?ap1 - airport ?ap2 - airport)
    :precondition (and (at ?a ?ap1) (airport ?ap1) (airport ?ap2))
    :effect (and (not (at ?a ?ap1)) (at ?a ?ap2)))

  (:action load
    :parameters (?p - package ?a - airplane ?ap - airport)
    :precondition (and (at ?a ?ap) (airport ?ap) (at-package ?p ?ap) (free ?a))
    :effect (and (holding ?p ?a) (not (at-package ?p ?ap)) (not (free ?a))))

  (:action unload
    :parameters (?p - package ?a - airplane ?ap - airport)
    :precondition (and (at ?a ?ap) (airport ?ap) (holding ?p ?a))
    :effect (and (not (holding ?p ?a)) (at-package ?p ?ap) (free ?a))))

```

The above code produces the following error -> There is a semantic error where unknown predicate 'at-package' used in precondition statement of action name 'pickup'. Remove 'at-package' from the precondition statement of all actions having it and replan that action only.

Instruction 1: Correct the error and give the entire PDDL code in code blocks and please do not give any explanations in the output.
Instruction 2: Do not create a problem file and do not use conditional expressions.
**LLM MODEL** (HUGGING_FACE):
```pddl 

(define (domain delivery-domain)
(:requirements :strips :typing)
(:types package location - object vehicle truck airplane airport - vehicle)
(:predicates
    (at ?v - vehicle ?l - location)
    (free ?v - vehicle)
    (holding ?p - package ?v - vehicle)
    (connected ?l1 - location ?l2 - location)
    (airport ?a - airport)
    (package-at ?p - package ?l - location))

(:action pickup
:parameters (?p - package ?t - truck ?l1 - location ?l2 - location)
:precondition (and (at ?t ?l1) (connected ?l1 ?l2) (package-at ?p ?l2))
:effect (and (not (package-at ?p ?l2)) (holding ?p ?t)))

(:action dropoff
:parameters (?p - package ?t - truck ?l1 - location ?l2 - location)
:precondition (and (at ?t ?l1) (connected ?l1 ?l2) (holding ?p ?t))
:effect (and (not (holding ?p ?t)) (package-at ?p ?l2) (not (at ?t ?l1)) (at ?t ?l2)))

(:action fly
:parameters (?a - airplane ?ap1 - airport ?ap2 - airport)
:precondition (and (at ?a ?ap1) (airport ?ap1) (airport ?ap2))
:effect (and (not (at ?a ?ap1)) (at ?a ?ap2)))

(:action load
:parameters (?p - package ?a - airplane ?ap - airport)
:precondition (and (at ?a ?ap) (airport ?ap) (package-at ?p ?ap) (free ?a))
:effect (and (holding ?p ?a) (not (package-at ?p ?ap)) (not (free ?a))))

(:action unload
:parameters (?p - package ?a - airplane ?ap - airport)
:precondition (and (at ?a ?ap) (airport ?ap) (holding ?p ?a))
:effect (and (not (holding ?p ?a)) (package-at ?p ?ap) (free ?a))))

```