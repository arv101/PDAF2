!$Id: initialize.F90 61 2019-02-01 08:49:36Z lnerger $
!BOP
!
! !ROUTINE: initialize  --- initialize the Lorenz 2005 model - III
!
! !INTERFACE:
SUBROUTINE initialize()

! !DESCRIPTION:
! Routine to perform initialization of the Lorenz 2005 model - III.
! The model is introduced in E. N. Lorenz, Designing Chaotic Models
! J. Atm. Sci. 62 (2005) 1574-1587.
!
! Here the model is implemented using a 4th order Runge-Kutta scheme.
! Because this model is typically used with small dimensions, it is
! implemented here ithout parallelization.
!
! !REVISION HISTORY:
! 2009-10 - Lars Nerger - Initial code
! Later revisions - see svn log
!
! !USES:
  USE mod_model, &        ! Model variables
       ONLY: dim_state, dt, step_null, step_final, x, forcing, k_avg, &
       fluctuate_coef, coupling_coef, smoothing_scale
  USE mod_modeltime, &    ! Time information for model integration
       ONLY: time, total_steps
  USE mod_parallel, &     ! Parallelization variables
       ONLY: mype_world
  USE mod_memcount, &     ! Counting allocated memory
       ONLY: memcount, memcount_ini, memcount_get
  USE parser, &           ! Parse command lines
       ONLY: handle, parse
  USE output_netcdf, &    ! NetCDF output
       ONLY: file_state, delt_write, init_netcdf

  IMPLICIT NONE

!EOP

! *** local variables **
  INTEGER, SAVE :: iseed(4)          ! seed array for random number routine


! *** Model specifications ***
  ! Fig 6 of the paper
  dim_state       = 960     ! State dimension
  forcing         = 15.0    ! Forcing parameter
  k_avg           = 32      ! Averaging factor k
  fluctuate_coef  = 10.0    ! fluctuate coefficient b
  coupling_coef   = 2.5     ! coupling coefficient c
  smoothing_scale = 12      ! smoothing scale I
  dt          = 0.005       ! Size of time step
  step_null   = 0           ! initial time step
  total_steps = 5000        ! number of time steps

  file_state = 'state.nc'  ! Name of output file for state trajectory
  delt_write = 1           ! Output interval in time steps (0 for no output)


! *** Parse command line options ***
  handle = 'dim_state'               ! state dimension of dummy model
  CALL parse(handle, dim_state)
  handle = 'forcing'                 ! Forcing parameter
  CALL parse(handle, forcing)
  handle = 'k_avg'                   ! Averaging range
  CALL parse(handle, k_avg)
  handle = 'fluctuate_coef'          ! Fluctuate coefficient
  CALL parse(handle, fluctuate_coef)
  handle = 'coupling_coef'           ! Coupling coefficient
  CALL parse(handle, coupling_coef)
  handle = 'smoothing_scale'         ! Smoothing scale
  CALL parse(handle, smoothing_scale)
  handle = 'dt'                      ! Time step size
  CALL parse(handle, dt)
  handle = 'step_null'               ! Initial time step
  CALL parse(handle, step_null)
  handle = 'total_steps'             ! total number of time steps
  CALL parse(handle, total_steps)
  handle = 'file_state'              ! Name of output file
  CALL parse(handle, file_state)
  handle = 'delt_write'              ! Output interval
  CALL parse(handle, delt_write)

! *** Define final time step ***
  step_final = step_null + total_steps

! *** Screen output ***
  screen2: IF (mype_world == 0) THEN
     WRITE (*, '(1x, a)') 'INITIALIZE MODEL'
     WRITE (*, '(22x,a)') 'MODEL: Lorenz 05 III'
     WRITE (*, '(5x, a, i7)') &
          'Global model dimension:', dim_state
     WRITE (*, '(10x,a,es10.2)') 'Forcing parameter:', forcing
     WRITE (*, '(5x, a, i7)') 'Averaging parameter:', k_avg
     WRITE (*, '(10x,a,es10.2)') 'Fluctuate coefficient:', fluctuate_coef
     WRITE (*, '(10x,a,es10.2)') 'Coupling coefficient:', coupling_coef
     WRITE (*, '(5x, a, i7)') 'Smoothing scale:', smoothing_scale
     WRITE (*, '(17x, a, i7, a, i7, a1)') &
          'Time steps:', total_steps, '  (final step:', step_final, ')'
     IF (step_null /= 0) WRITE (*, '(10x, a, i7)') 'Initial time step:', step_null
     WRITE (*, '(13x, a, f10.3)') 'Time step size:', dt
#ifndef USE_PDAF
     IF (delt_write > 0) THEN
        WRITE (*, '(5x,a,i4,a)') &
             'Write output after each ',delt_write,' time steps'
        WRITE (*, '(10x,a,a)') 'Output file: ',TRIM(file_state)
     ELSE
        WRITE (*, '(5x,a)') 'Do not write model output!'
     END IF
#endif
  END IF screen2


! *** Initialize dimensions and fields with domain decompsition

  ! Allocate a model field
  ALLOCATE(x(dim_state))
  ! count allocated memory
  CALL memcount(1, 'r', dim_state)

  ! Standard seed
  iseed(1) = 1000
  iseed(2) = 2034
  iseed(3) = 0
  iseed(4) = 3

  ! Initialize state with random values
  CALL dlarnv(2, iseed, dim_state, x)

  x = forcing + x * 0.0001

  ! Initialize model time
  time = REAL(step_null) * dt

  ! Initialize netcdf output
#ifndef USE_PDAF
  CALL init_netcdf(step_null, time, dt, forcing, dim_state, x, k_avg, &
       fluctuate_coef, coupling_coef, smoothing_scale)
#endif

END SUBROUTINE initialize
