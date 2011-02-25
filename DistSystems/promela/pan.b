	switch (t->back) {
	default: Uerror("bad return move");
	case  0: goto R999; /* nothing to undo */

		 /* PROC :init: */

	case 3: /* STATE 1 */
		;
		;
		delproc(0, now._nr_pr-1);
		;
		goto R999;

	case 4: /* STATE 2 */
		;
		XX = 1;
		unrecv(((P1 *)this)->child, XX-1, 0, ((P1 *)this)->q, 1);
		unrecv(((P1 *)this)->child, XX-1, 1, ((P1 *)this)->r, 0);
		((P1 *)this)->q = trpt->bup.ovals[0];
		((P1 *)this)->r = trpt->bup.ovals[1];
		;
		;
		ungrab_ints(trpt->bup.ovals, 2);
		goto R999;
;
		;
		
	case 6: /* STATE 4 */
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC division */

	case 7: /* STATE 1 */
		;
	/* 0 */	((P0 *)this)->y = trpt->bup.oval;
		;
		;
		goto R999;

	case 8: /* STATE 2 */
		;
		m = unsend(((P0 *)this)->res);
		;
		goto R999;
;
		;
		
	case 10: /* STATE 4 */
		;
	/* 2 */	((P0 *)this)->q = trpt->bup.ovals[2];
	/* 1 */	((P0 *)this)->y = trpt->bup.ovals[1];
	/* 0 */	((P0 *)this)->x = trpt->bup.ovals[0];
		;
		delproc(0, now._nr_pr-1);
		;
		ungrab_ints(trpt->bup.ovals, 3);
		goto R999;
	}

