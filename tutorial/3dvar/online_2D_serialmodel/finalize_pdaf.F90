!$Id$
!>  Finalize PDAF
!!
!! This routine calls routines for output on
!! timing and memory use, to deallocate
!! PDAF_internal arrays, and to finalize MPI.
!!
!! __Revision history__
!! * 2004-11 - Lars Nerger - Initial code
!! * Later revisions - see repository log
!!
SUBROUTINE finalize_pdaf()

  USE pdaf_interfaces_module, &   ! Interface definitions to PDAF core routines
       ONLY: PDAF_print_info, PDAF_deallocate
  USE mod_parallel_pdaf, &        ! Parallelization variables
       ONLY: finalize_parallel, mype_world

  IMPLICIT NONE    

  ! *** Show allocated memory for PDAF ***
  IF (mype_world==0) CALL PDAF_print_info(2)

  ! *** Print PDAF timings onto screen ***
  IF (mype_world==0) CALL PDAF_print_info(3)

  ! *** Deallocate PDAF arrays ***
  CALL PDAF_deallocate()

  ! *** Finalize parallel MPI region ***
  CALL finalize_parallel()

END SUBROUTINE finalize_pdaf
