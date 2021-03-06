      subroutine lis_cmde2 ( cmde_num, iflag, outfil )
      integer cmde_num, iflag, outfil

      include 'ipfinc/parametr.inc'

      include 'ipfinc/alpha.inc'
      include 'ipfinc/cmde_com.inc'
      include 'ipfinc/blank.inc'
      include 'ipfinc/branch.inc'
      include 'ipfinc/bus.inc'
      include 'ipfinc/intbus.inc'
      include 'ipfinc/prt.inc'
      include 'ipfinc/comm_mode.inc'

      integer ptr, qptr, pbr, k1, k2
      character br_own*3, rec_type(4)*1, chg_type(4)*1
      integer fmt

      data rec_type / 'B', '+', 'L', 'T' /
      data chg_type / 'D', 'M', ' ', 'R' /

      if ( iflag .eq. 1 ) then
         write (outbuf, 10) 
   10    format (t26, 'Results in:')
         write (outfil, '(a)'), outbuf
         outbuf = ' '
         write (outfil, '(a)'), outbuf
         write (outbuf, 20)
   20    format (t26, 'Ty  Ch  Own  Zones  Bus1           Bus2',
     &      '            /----- Load -----//----- Shunt ----/',
     &      '/-- Generation --/') 
         write (outfil, '(a)'), outbuf
         write (outbuf, 30)
   30    format (t84, 'MW     MVAR       MW     MVAR       ',
     &           'MW     MVAR') 
         write (outfil, '(a)'), outbuf
         assign 930 to fmt
      else
         outbuf = '  --- Ty  Ch  Own  Zones  Bus1           Bus2'
         write (outfil, '(a)'), outbuf
         assign 940 to fmt
      endif

      ptr = comm_ptr(cmde_num)
      do while (ptr .gt. 0)
        qptr = change_ptr(ptr)
        do while (qptr .gt. 0)
          if (orig_type(1,qptr) .eq. 1 .or. 
     &        orig_type(1,qptr) .eq. 2) then
            k1 = orig_type(3,qptr)
            if ( iflag .eq. 1 ) then
              write (outbuf, 910) rec_type(orig_type(1,qptr)),
     &              chg_type(orig_type(2,qptr)), owner(k1),
     &              zone(k1), bus(k1), base(k1),
     &              orig_val(3,qptr) * bmva, orig_val(4,qptr) * bmva,
     &              orig_val(5,qptr) * bmva, orig_val(6,qptr) * bmva,
     &              (orig_val(1,qptr) + orig_val(3,qptr)) * bmva,
     &              (orig_val(2,qptr) + orig_val(4,qptr)) * bmva
            else
              write (outbuf, 920) rec_type(orig_type(1,qptr)),
     &              chg_type(orig_type(2,qptr)), owner(k1),
     &              zone(k1), bus(k1), base(k1)
            endif
  910       format (t26, a1, 3x, a1, 3x, a3, 2x, a2, 5x, a8, f6.1,
     &              t77, 6f9.1)
  920       format ('  --- ', a1, 3x, a1, 3x, a3, 2x, a2, 5x, a8, f6.1)
            write (outfil, '(a)'), outbuf
          else if (orig_type(1,qptr) .eq. 3 .or. 
     &             orig_type(1,qptr) .eq. 4) then
            k1 = orig_type(3,qptr)
            k2 = orig_type(4,qptr)
            if (inp2alf(k1) .lt. inp2alf(k2))
     &        then

              pbr = iabs(brnch_ptr(orig_type(6,qptr)))
              if (pbr .gt. 0) then
                call getchr(3,br_own,kbrnch(3,pbr))
              else
                br_own = ' '
              endif
              write (outbuf, fmt) 
     &              rec_type(orig_type(1,qptr)),
     &              chg_type(orig_type(2,qptr)),
     &              br_own, zone(k1), zone(k2),
     &              bus(k1), base(k1), bus(k2), base(k2), 
     &              char(orig_type(5,qptr))
  930         format (t26, a1, 3x, a1, 3x, a3, 2x, a2, 1x, a2,
     &                2x, a8, f6.1, 1x, a8, f6.1, 1x, a)
  940         format ('  --- ', a1, 3x, a1, 3x, a3, 2x, a2, 1x, a2,
     &                2x, a8, f6.1, 1x, a8, f6.1, 1x, a)
              write (outfil, '(a)'), outbuf
            endif
          endif
          qptr = orig_nxt(qptr)
        enddo
        ptr = change_nxt(ptr)
      enddo
      return

      end

