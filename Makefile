COMPILER_FLAGS = --opt='-O3 -fopenmp -m64 -march=native' --f90flags='-I${MKLROOT}/include'
LINKER_FLAGS = -lgomp -lpthread -lm -ldl
MKL_LINKER_FLAGS = -L${MKLROOT}/lib/intel64 -lmkl_rt

F90_FLAGS = -O3 -m64 -march=native -I${MKLROOT}/include

all: qml_mpi.so driver

qml_mpi.so: qml_mpi.f90

	f2py -c qml_mpi.f90 -m qml_mpi $(COMPILER_FLAGS) $(LINKER_FLAGS) $(MKL_LINKER_FLAGS)

driver: driver.f90

	gfortran driver.f90 -o driver $(F90_FLAGS) $(MKL_LINKER_FLAGS)

driver_mpi: driver_mpi.f90

	mpifort driver_mpi.f90 -o driver_mpi -lmkl_scalapack_ilp64 -lmkl_intel_ilp64 -lmkl_sequential -lmkl_core -lmkl_blacs_openmpi_ilp64 -lpthread -lm -ldl 
