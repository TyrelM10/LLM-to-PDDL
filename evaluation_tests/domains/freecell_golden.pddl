(define (domain freecell)
  (:requirements :strips) 
  (:predicates (on ?c1 ?c2)
	       (incell ?c)
	       (clear ?c)
	       (cellspace ?n)
	       (colspace ?n)
	       (home ?c)
	       (bottomcol ?c)
	       (canstack ?c1 ?c2)
	       (suit ?c ?s)
	       (value ?c ?v)
	       (successor ?n1 ?n0)
 )


  (:action move
	   :parameters (?card ?oldcard ?newcard)
	   :precondition (and (clear ?card) 
			      (clear ?newcard)
			      (canstack ?card ?newcard)
			      (on ?card ?oldcard))
	   :effect (and
		    (on ?card ?newcard)
		    (clear ?oldcard)
		    (not (on ?card ?oldcard))
		    (not (clear ?newcard))))

  (:action move-b
	   :parameters (?card ?newcard ?cols ?ncols)
	   :precondition (and (clear ?card) 
			      (bottomcol ?card)
			      (clear ?newcard)
			      (canstack ?card ?newcard)
			      (colspace ?cols)
			      (successor ?ncols ?cols))
	   :effect (and (on ?card ?newcard)
			(colspace ?ncols)
			(not (bottomcol ?card))
			(not (clear ?newcard))
			(not (colspace ?cols))))


  (:action sendtofree 
	   :parameters (?card ?oldcard ?cells ?ncells)
	   :precondition (and
			  (clear ?card) 
			  (on ?card ?oldcard)
			  (cellspace ?cells)
			  (successor ?cells ?ncells))
	   :effect (and
		    (incell ?card) 
		    (clear ?oldcard)
		    (cellspace ?ncells)
		    (not (on ?card ?oldcard))
		    (not (clear ?card))
		    (not (cellspace ?cells))))

  (:action sendtofree-b 
	   :parameters (?card ?cells ?ncells ?cols ?ncols)
	   :precondition (and (clear ?card) 
			      (bottomcol ?card)
			      (cellspace ?cells)
			      (successor ?cells ?ncells)
			      (colspace ?cols)
			      (successor ?ncols ?cols))
	   :effect (and
		    (incell ?card)
		    (colspace ?ncols)
		    (cellspace ?ncells)
		    (not (bottomcol ?card))
		    (not (clear ?card))
		    (not (colspace ?cols))
		    (not (cellspace ?cells))))


(:action sendtonewcol
	 :parameters (?card ?oldcard ?cols ?ncols)
	 :precondition (and
			(clear ?card)
			(colspace ?cols)
			(successor ?cols ?ncols)
			(on ?card ?oldcard))
	 :effect (and
		  (bottomcol ?card) 
		  (clear ?oldcard)
		  (colspace ?ncols)
		  (not (on ?card ?oldcard))
		  (not (colspace ?cols))))

(:action sendtohome
	 :parameters (?card ?oldcard ?suit ?vcard ?homecard ?vhomecard)
	 :precondition (and
			(clear ?card) 
			(on ?card ?oldcard)
			(home ?homecard)
			(suit ?card ?suit)
			(suit ?homecard ?suit)
			(value ?card ?vcard)
			(value ?homecard ?vhomecard)
			(successor ?vcard ?vhomecard))
	 :effect (and (home ?card)
		      (clear ?oldcard)
		      (not (on ?card ?oldcard))
                      (not (home ?homecard))
		      (not (clear ?card))))

(:action sendtohome-b
	 :parameters (?card ?suit ?vcard ?homecard
			    ?vhomecard ?cols ?ncols)
	 :precondition (and (clear ?card) 
			    (bottomcol ?card)
			    (home ?homecard)
			    (suit ?card ?suit)
			    (suit ?homecard ?suit)
			    (value ?card ?vcard)
			    (value ?homecard ?vhomecard)
			    (successor ?vcard ?vhomecard)
			    (colspace ?cols)
			    (successor ?ncols ?cols))
	 :effect (and (home ?card)
		      (colspace ?ncols)
		      (not (home ?homecard))
		      (not (clear ?card))
		      (not (bottomcol ?card))
		      (not (colspace ?cols))))


(:action homefromfreecell
	 :parameters (?card ?suit ?vcard
			    ?homecard ?vhomecard ?cells ?ncells)
	 :precondition (and 
			(incell ?card)
			(home ?homecard) 
			(suit ?card ?suit)
			(suit ?homecard ?suit)
			(value ?card ?vcard)
			(value ?homecard ?vhomecard)
			(successor ?vcard ?vhomecard)
			(cellspace ?cells)
			(successor ?ncells ?cells))
	 :effect (and
		  (home ?card)
		  (cellspace ?ncells)
		  (not (incell ?card))
		  (not (cellspace ?cells))
		  (not (home ?homecard))))

(:action colfromfreecell
	 :parameters (?card ?newcard ?cells ?ncells)
	 :precondition (and  (incell ?card)
			     (clear ?newcard)
			     (canstack ?card ?newcard)
			     (cellspace ?cells)
			     (successor ?ncells ?cells))
	 :effect (and (cellspace ?ncells)
		      (clear ?card)
		      (on ?card ?newcard)
		      (not (incell ?card))
		      (not (cellspace ?cells))
		      (not (clear ?newcard))))

(:action newcolfromfreecell
	 :parameters (?card ?cols ?ncols ?cells ?ncells)
	 :precondition (and (incell ?card)
			    (colspace ?cols)
			    (cellspace ?cells)
			    (successor ?cols ?ncols)
			    (successor ?ncells ?cells))
	 :effect (and (bottomcol ?card) 
		      (clear ?card)
		      (colspace ?ncols)
		      (cellspace ?ncells)
		      (not (incell ?card))
		      (not (colspace ?cols))
		      (not (cellspace ?cells)))))
