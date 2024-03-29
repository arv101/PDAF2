!$Id: collect_state_pdaf.F90 332 2019-12-30 09:37:03Z lnerger $
!>  Initialize state vector from model fields
!!
!! User-supplied call-back routine for PDAF.
!!
!! Used in all filters.
!!
!! This subroutine is called during the forecast 
!! phase from PDAF_put_state_X or PDAF_assimilate_X
!! after the propagation of each ensemble member. 
!! The supplied state vector has to be initialized
!! from the model fields (typically via a module). 
!! With parallelization, MPI communication might be 
!! required to initialize state vectors for all 
!! subdomains on the model PEs. 
!!
!! The routine is executed by each process that is
!! participating in the model integrations.
!!
!! For the 2D tutorial model the state vector and
!! the model field are identical. Hence, state vector
!! directly initialized from the model field by
!! each model PE.
!!
!! __Revision history:__
!! * 2013-09 - Lars Nerger - Initial code
!! * Later revisions - see repository log
!!
SUBROUTINE collect_state_pdaf(dim_p, state_p)

  USE mod_model, &             ! Model variables
       ONLY: nx, ny, v

  IMPLICIT NONE
  
! *** Arguments ***
  INTEGER, INTENT(in) :: dim_p           !< PE-local state dimension
  REAL, INTENT(inout) :: state_p(dim_p)  !< local state vector

! *** local variables ***
  INTEGER :: j         ! Counters
  ! real(8), allocatable :: ucopy(:,:)
  

! *************************************************
! *** Initialize state vector from model fields ***
! *************************************************


  ! DO j = 1, nx
  !    state_p(1 + (j-1)*ny : j*ny) = v(1:ny, j)
  ! END DO
  state_p = reshape(v, (/nx*nx/))
  ! state_p(:) = u(:)


  
END SUBROUTINE collect_state_pdaf
