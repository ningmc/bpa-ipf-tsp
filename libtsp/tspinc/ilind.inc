*BEGIN ILIND
      COMMON/ILINDN/ILINDN(10,3,500)
      COMMON/ILINDC/ILINDC(3,500)
      CHARACTER*8 ILINDC
      DIMENSION BRNDN(10,3,500)
      EQUIVALENCE (ILINDN,BRNDN)
