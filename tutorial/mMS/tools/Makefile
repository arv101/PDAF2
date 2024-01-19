#######################################################

.SUFFIXES: .F90 .o 

######################################################


# Root directory of PDAF package
BASEDIR = ../../..

# Include machine-specific definitions
# For available include files see directory make.arch
# To choose a file, set PDAF_ARCH either here or by an
# environment variable.
include $(BASEDIR)/make.arch/$(PDAF_ARCH).h

######################################################

OBJ_GENOBS = generate_obs.o \
			 parser_no_mpi.o

OBJ_ENS  = generate_ens.o \
		   parser_no_mpi.o
	
### Name of Executables ##############################################

EXE_GENOBS = generate_obs
EXE_ENS  = generate_ens

######################################################

info:
	@echo "Makefile to generate observations and ensemble for Mitchell-Schaeffer Model"

$(EXE_GENOBS) : $(OBJ_GENOBS)
	rm -f $@
	$(LD)  $(OPT)  -o $@ $(MODULES) $(OBJ_GENOBS) $(NC_LIB) $(LINK_LIBS)

$(EXE_ENS) : libpdaf-d.a $(OBJ_ENS)
	rm -f $@
	$(LD)  $(OPT)  -o $@ $(MODULES) $(OBJ_ENS) $(NC_LIB) -L$(BASEDIR)/lib -lpdaf-d $(LINK_LIBS)

all: $(EXE_GENOBS) $(EXE_ENS)

.F90.o :
	$(FC) $(OPT) $(CPP_DEFS) $(NC_INC) -c $*.F90 

libpdaf-d.a: 
	@echo "++++++ Generate Filter library ++++++"
	@cd $(BASEDIR)/src; make;

clean :
	rm -f *.o *.mod *.a $(EXE_GENOBS) $(EXE_ENS)