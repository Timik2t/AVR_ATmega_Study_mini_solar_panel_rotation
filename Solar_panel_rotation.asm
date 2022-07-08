
.include "m8515def.inc"
.def temp1=R17
.def temp2=R18
.def counter5=R27
.def counter1=r20
.def counter2=r21
.def data=r22
.def counter3=r23
.def data1=r24
.def counter4=r25
.def data2=r26


 main:
 cli
 ldi temp1,$1D
  out DDRB,temp1
  ldi temp1,$FF
  out DDRC,temp1
   ldi r30,low(RAMEND)
 out SPL,r30
 ldi r30,high(RAMEND)
 out SPH,r30
 sbi portB,4


 pravo:
 clr data2
 sbi portb,3

 main1:
 clr data1
 ldi counter3,$10

  Acprun:
 
	sbi PORTB,0 
	rcall delay
	cbi PORTB,0 
    nop
	ldi counter1,$08


	sclckrun:
		sbi PORTB,2 
		rcall write 
		cbi PORTB,2 
		dec counter1
		brne sclckrun
	nop
	rjmp usred

    write:
	 sbic PINB,1 
	 inc data 
	 lsl data 
	 ret

     usred:
      dec counter3
      add data1,data
      cpi counter3,$00
     breq sravnenie
      rcall delay5
     rjmp acprun

     sravnenie:
      lsr data1
      rol temp2
      lsr data1
      rol temp2
      lsr data1
      rol temp2
      lsr data1
      cp temp2,data2
     brlo led1
      mov data2,data1
     rjmp main1
     led1:
      out PortC,data1
      cbi portB,3
      rcall delay2

     levo:
      out PortC,data2
      cbi portb,4
      cp data1,data2
     breq stop1
     rjmp main1

  delay:
	ldi counter2,$03
	 delay1:
	  dec counter2
	  brne delay1
    ret

	
  delay5:
   ldi counter2,$FF
   delay7:
    ldi counter1,$02
    delay8:
     dec counter1
     brne delay8
     dec counter2
     brne delay7
     ret

  delay2:
   ldi counter2,$FF
   delay3:
    ldi counter1,$A0
    delay4:
     dec counter1
     brne delay4
     dec counter2
     brne delay3
     ret

   stop1 : 
    sbi portb,4 
     rcall delay2
     rcall delay2
     rcall delay2
   rjmp pravo




