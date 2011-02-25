	switch (t->forw) {
	default: Uerror("bad forward move");
	case 1: /* generic 'goto' or 'skip' */
		IfNotBlocked
		m = 3; goto P999;
	case 2: /* generic 'else' */
		IfNotBlocked
		if (trpt->o_pm&1) continue;
		m = 3; goto P999;

		 /* PROC :init: */
	case 3: /* STATE 1 - line 11 "pan_in" - [(run division(7,3,0,child))] (0:0:0 - 1) */
		IfNotBlocked
		if (!(addproc(0, 7, 3, 0, ((P1 *)this)->child)))
			continue;
		m = 3; goto P999; /* 0 */
	case 4: /* STATE 2 - line 12 "pan_in" - [child?q,r] (0:0:2 - 1) */
		if (q_len(((P1 *)this)->child) == 0) continue;

		XX=1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = ((P1 *)this)->q;
		(trpt+1)->bup.ovals[1] = ((P1 *)this)->r;
		;
		((P1 *)this)->q = qrecv(((P1 *)this)->child, XX-1, 0, 0);
#ifdef VAR_RANGES
		logval(":init::q", ((P1 *)this)->q);
#endif
		;
		((P1 *)this)->r = qrecv(((P1 *)this)->child, XX-1, 1, 1);
#ifdef VAR_RANGES
		logval(":init::r", ((P1 *)this)->r);
#endif
		;
		;
		m = 4; goto P999; /* 0 */
	case 5: /* STATE 3 - line 13 "pan_in" - [printf('Result: %d %d\\n',q,r)] (0:0:0 - 1) */
		IfNotBlocked
		Printf("Result: %d %d\n", ((P1 *)this)->q, ((P1 *)this)->r);
		m = 3; goto P999; /* 0 */
	case 6: /* STATE 4 - line 14 "pan_in" - [-end-] (0:0:0 - 1) */
		IfNotBlocked
		if (!delproc(1, II)) continue;
		m = 3; goto P999; /* 0 */

		 /* PROC division */
	case 7: /* STATE 1 - line 3 "pan_in" - [((y>x))] (0:0:1 - 1) */
		IfNotBlocked
		if (!((((P0 *)this)->y>((P0 *)this)->x)))
			continue;
		/* dead 1: y */  (trpt+1)->bup.oval = ((P0 *)this)->y;
		((P0 *)this)->y = 0;
		m = 3; goto P999; /* 0 */
	case 8: /* STATE 2 - line 3 "pan_in" - [res!q,x] (0:0:0 - 1) */
		IfNotBlocked
		if (q_full(((P0 *)this)->res))
			continue;
		qsend(((P0 *)this)->res, 0, ((P0 *)this)->q, ((P0 *)this)->x);
		m = 2; goto P999; /* 0 */
	case 9: /* STATE 3 - line 4 "pan_in" - [((x>=y))] (0:0:0 - 1) */
		IfNotBlocked
		if (!((((P0 *)this)->x>=((P0 *)this)->y)))
			continue;
		m = 3; goto P999; /* 0 */
	case 10: /* STATE 4 - line 4 "pan_in" - [(run division((x-y),y,(q+1),res))] (0:0:3 - 1) */
		IfNotBlocked
		if (!(addproc(0, (((P0 *)this)->x-((P0 *)this)->y), ((P0 *)this)->y, (((P0 *)this)->q+1), ((P0 *)this)->res)))
			continue;
		/* dead 1: x */  (trpt+1)->bup.ovals = grab_ints(3);
		(trpt+1)->bup.ovals[0] = ((P0 *)this)->x;
		((P0 *)this)->x = 0;
		/* dead 1: y */  (trpt+1)->bup.ovals[1] = ((P0 *)this)->y;
		((P0 *)this)->y = 0;
		/* dead 1: q */  (trpt+1)->bup.ovals[2] = ((P0 *)this)->q;
		((P0 *)this)->q = 0;
		m = 3; goto P999; /* 0 */
/* STATE 7 - line 6 "pan_in" - [-end-] (0:0 - 3) same as 6 (0:0 - 1) */
	case  _T5:	/* np_ */
		if (!((!(trpt->o_pm&4) && !(trpt->tau&128))))
			continue;
		/* else fall through */
	case  _T2:	/* true */
		m = 3; goto P999;
	}

