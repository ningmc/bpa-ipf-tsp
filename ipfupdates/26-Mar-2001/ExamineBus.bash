#!/bin/sh
#
#  This script reads basecase filenames from an input file 'p1'.
#  For each file read in, it generates an *.bash file to perform a
#  specific IPF_REPORTS task.
# 
echo "Enter master file list"
finished=0
while [ $finished -eq 0 ]; do
  read input_file
  if [ ! -e $input_file ]; then
    echo "File $input_file does not exist."
  else
    finished=1
  fi
done

# Read master file 

while read basefile; do
  echo "File $basefile"
  if [ ! -e $basefile ]; then
    echo "File $basefile does not exist."
  else
    file=`basename ${basefile%.*}`
    outputfile=${file%.*}.pse
    rm -f ./temporary.bash
    rm -f ./temporary.data
    {
      echo "#!/bin/sh"
      echo "#          "
      echo "#***************************************************************"
      echo "# Launching ipf_reports"
      echo "****************************************************************"
      echo "NO_MORE=NO_MORE"
      echo "/usr/bin/ipf_reports"
    } > temporary.bash
    {
      echo "$basefile"
      echo "o"
      echo "f"
      echo "$outputfile"
      echo "1"
      echo "COV EAST,230"
      echo "COV CNTR,230"
      echo "COV WEST,230"
      echo "MAPLE VL,230"
      echo "SNOK S2 ,230"
      echo "TACOMA  ,230"
      echo "MONROE  ,230"
      echo "RAVER   ,500"
      echo "BERYDALE,230"
      echo "CHRISBUS,230"
      echo "OBRIEN  ,230"
      echo "SAMMAMSH,230"
      echo "WHITE RV,230"
      echo "TALBOT N,230"
      echo "TALBOT S,230"
      echo ""
      echo "q"
      echo "q"
    } > temporary.data
    chmod a+x temporary.bash
    echo "#***************************************************************"
    echo "# Launching ipf_reports Base: $basefile "
    echo "#                       Output: $outputfile"
    echo "****************************************************************"
    ./temporary.bash < temporary.data
  fi
done < $input_file
