#/bin/bash!

cd pyranda
np=`nproc`
echo "Starting tests with ${np} processes"
echo "Run #1:"
time (mpiexec -np ${np} python TBL3D.py) 2>> time.txt
echo "Run #2:"
time (mpiexec -np ${np} python TBL3D.py) 2>> time.txt
echo "Run #3:"
time (mpiexec -np ${np} python TBL3D.py) 2>> time.txt
echo "Finished :)"
