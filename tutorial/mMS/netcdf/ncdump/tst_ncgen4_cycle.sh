#!/bin/sh

if test "x$srcdir" = x ; then srcdir=`pwd`; fi 
. ../test_common.sh

. ${srcdir}/tst_ncgen_shared.sh

if test "${MODE}" = 3 ; then
  TESTSET="${TESTS3} ${BIGTESTS3} ${BIGBIG3}"
  if test "${KFLAG}" = 4 ; then
    TESTSET="${TESTSET} ${SPECIALTESTS3}"
  fi
else
TESTSET="${TESTS3} ${TESTS4} ${BIGTESTS} ${SPECIALTESTS}"
fi

echo "*** Cycle testing ncgen with -k${KFLAG}"

mkdir ${RESULTSDIR}
cd ${RESULTSDIR}
for x in ${TESTSET} ; do
  test "x$verbose" = x1 && echo "*** Testing: ${x}"
  # determine if we need the specflag set
  specflag=
  headflag=
  for s in ${SPECIALTESTS} ; do
    if test "x${s}" = "x${x}" ; then specflag="-s"; headflag="-h"; fi
  done
  # determine if this is an xfailtest;if so, then no point in running it
  isxfail=0
  for t in ${XFAILTESTS} ; do
    if test "x${t}" = "x${x}" ; then isxfail=1; fi
  done
  isnocycle=0
  for t in ${NOCYCLE} ; do
    if test "x${t}" = "x${x}" ; then isnocycle=1; fi
  done
  if test "${isxfail}" = "1"; then
	echo "xfail test: ${x}: ignored"
        xfailcount=`expr $xfailcount + 1`	
  elif test "${isnocycle}" = "1"; then
	echo "test: ${x}: ignored for cycle test"
  else
    rm -f ${x}_$$.nc ${x}_$$.dmp
    # step 1: use original cdl to build the .nc
    ${NCGEN} -b -k${KFLAG} -o ${x}_$$.nc ${cdl}/${x}.cdl
    # step 2: dump .nc file
    ${NCDUMP} ${headflag} ${specflag} -n ${x} ${x}_$$.nc > ${x}_$$.dmp
    # step 3: use ncgen and the ncdump output to (re-)build the .nc
    rm -f ${x}_$$.nc
    ${NCGEN} -b -k${KFLAG} -o ${x}_$$.nc ${x}_$$.dmp
    # step 4: dump .nc file again
    ${NCDUMP} ${headflag} ${specflag} -n ${x} ${x}_$$.nc > ${x}_$$.dmp2
    # compare the two ncdump outputs
    if diff -b -w ${x}_$$.dmp ${x}_$$.dmp2 ; then ok=1; else ok=0; fi
    rm -f ${x}_$$.nc ${x}_$$.dmp
    if test "x$ok" = "x1" ; then
      test "x$verbose" = x1 && echo "*** SUCCEED: ${x}"
      passcount=`expr $passcount + 1`
    else
      echo "*** FAIL: ${x}"
      failcount=`expr $failcount + 1`
    fi
  fi
done
cd ..

totalcount=`expr $passcount + $failcount + $xfailcount`
okcount=`expr $passcount + $xfailcount`

echo "*** PASSED: ${okcount}/${totalcount} ; ${failcount} unexpected failures; ${xfailcount} expected failures ignored"
rm -rf ${RESULTSDIR}

if test $failcount -gt 0 ; then
  exit 1
else
  exit 0
fi
