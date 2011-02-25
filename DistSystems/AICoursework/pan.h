#define SpinVersion	"Spin Version 5.2.5 -- 17 April 2010"
#define PanSource	"pan_in"

#ifdef WIN64
#define ONE_L	((unsigned long) 1)
#define long	long long
#else
#define ONE_L	(1L)
#endif
char *TrailFile = PanSource; /* default */
char *trailfilename;
#if defined(BFS)
#ifndef SAFETY
#define SAFETY
#endif
#ifndef XUSAFE
#define XUSAFE
#endif
#endif
#ifndef uchar
#define uchar	unsigned char
#endif
#ifndef uint
#define uint	unsigned int
#endif
#define DELTA	500
#ifdef MA
	#if NCORE>1 && !defined(SEP_STATE)
	#define SEP_STATE
	#endif
#if MA==1
#undef MA
#define MA	100
#endif
#endif
#ifdef W_XPT
#if W_XPT==1
#undef W_XPT
#define W_XPT 1000000
#endif
#endif
#ifndef NFAIR
#define NFAIR	2	/* must be >= 2 */
#endif
#define HAS_CODE
#define MERGED	1
#if !defined(HAS_LAST) && defined(BCS)
	#define HAS_LAST	1 /* use it, but */
	#ifndef STORE_LAST
		#define NO_LAST	1 /* dont store it */
	#endif
#endif
#if defined(BCS) && defined(BITSTATE)
	#ifndef NO_CTX
		#define STORE_CTX	1
	#endif
#endif
#ifdef NP	/* includes np_ demon */
#define HAS_NP	2
#define VERI	9
#define endclaim	3 /* none */
#endif
