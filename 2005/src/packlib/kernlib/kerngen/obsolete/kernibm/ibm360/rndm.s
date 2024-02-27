*
* $Id: rndm.s,v 1.1.1.1 1996/02/15 17:53:16 mclareni Exp $
*
* $Log: rndm.s,v $
* Revision 1.1.1.1  1996/02/15 17:53:16  mclareni
* Kernlib
*
*
RNDM     CSECT
*
* CERN PROGLIB# V104    RNDM            .VERSION KERNIBM  1.09  820119
*
*       UNIFORM RANDOM NUMBER GENERATOR FOR IBM 370
*       G.MARSAGLIA, K.ANANTHANARAYANAN, N.PAUL. MCGILL UNIV., MONTREAL
*       ONE-PARAMETER VERSION
*       ADAPTED AT CERN BY T.LINDELOF, SEPT 1977
*       RDMIN MODIFIED BY T LINDELOF AUG 1978
*            RNDM             R=RNDM(DUMMY)
#if defined(CERNLIB_QMIBMXA)
*        SPLEVEL  SET=2
RNDM     AMODE ANY
RNDM     RMODE ANY
#endif
       ENTRY RDMIN            CALL RDMIN(I1)
       ENTRY RDMOUT           CALL RDMOUT(I1)
       ENTRY IRNDM            K=IRNDM(DUMMY)
REGB   EQU    1
REGC   EQU    2
REGD   EQU    3
*
*     R=RNDM(DUMMY)           RESULT IS NORMALIZED FLOATING POINT VALUE
*                             UNIFORMLY DISTRIBUTED ON (0.0,1.0).
       USING *,15
       STM   REGB,REGD,24(13) SAVE REGISTERS 1,2,3
       L     REGD,MCGN        LOAD MCGN INTO REGD
       M     REGC,MULT        AND MULTIPLY BY 69069
       ST    REGD,MCGN        STORE RESULT,MODULO 2**32, AS NEW 'MCGN'
       SRL   REGD,8           SHIFT REGD RIGHT 8 BITS FOR F.P. FRACTION
       AL    REGD,CHAR        ADD CHARACTERISTIC X'40' INTO FIRST BYTE
       ST    REGD,FWD         STORE AT FWD, LOAD INTO FPR 0,
       LE    0,FWD            AND ADD NORMALIZED TO ZERO
       AE    0,Z              LEAVING RESULT 'RNDM' IN FPR 0.
RETRN1 LM    REGB,REGD,24(13)
       BCR   15,14            RETURN
*
*     K=IRNDM(DUMMY)          UNIFORMLY DISTRIBUTED POSITIVE INTEGER.
*
       USING IRNDM,15
IRNDM  STM   REGB,REGD,24(13) SAVE REGISTERS 1,2,3
       L     REGD,MCGN        LOAD MCGN INTO REGD
       M     REGC,MULT        AND MULTIPLY BY 69069
       ST    REGD,MCGN        STORE RESULT,MODULO 2**32, AS NEW 'MCGN'
       SRL   REGD,1           SHIFT LEFT 1 BIT,LEAVING SIGN BIT ZERO
       LR    0,REGD           AND MOVE RESULT 'IRNDM' TO GPR 0.
RETRN5 LM    REGB,REGD,24(13)
       BCR   15,14            RETURN
*
*   CALL RDMIN(I1)            I1 IS USED FOR STARTING THE
*                             SEQUENCE 'MCGN'
       USING RDMIN,15
RDMIN  STM   REGB,REGD,24(13) SAVE REGISTERS 1,2,3
       L     REGC,0(1)        LOAD ADDRESS OF I1 INTO REGC
       L     REGC,0(REGC)     LOAD VALUE OF I1 INTO REGC
       LTR   REGC,REGC
ST1    ST    REGC,MCGN        STORE AT 'MCGN'
RETRN0 LM    REGB,REGD,24(13) RESTORE REGISTERS 1,2,3
       BCR   15,14            AND RETURN
*
*         CALL RDMOUT(I1)
*
          USING RDMOUT,15
RDMOUT    STM   REGB,REGD,24(13)   SAVE REGISTERS 1,2,3
          L      REGC,0(1)         LOAD ADDR. OF I1 INTO REGC
          MVC    0(4,REGC),MCGN    MOVE MCGN TO I1
          LM     REGB,REGD,24(13)  RESTORE REGISTERS 1,2,3
          BCR    15,14             AND RETURN
*
*      CONSTANTS AND STORAGE RESERVATION
*
MCGN   DC     F'12345'
X7FF   DC     X'000007FF'
MULT   DC     F'69069'
CHAR   DC     X'40000000'
FWD    DC     F'0'
Z      DC     E'0.0'
       END
