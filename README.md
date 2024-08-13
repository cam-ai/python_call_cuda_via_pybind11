# python_call_cuda_via_pybind11
This sample guide you how to use python call cuda via pybind11

# Install pre-request pybind11
sudo apt-get install python3-pybind11

# Build
mkdir build
cd build
cmake ..
make
cd ..

# Run
python test_add.py

# Output
hello
7
result_shape w= 3
sum: 0    2.0 2.0 4.0
sum: 1    2.0 2.0 6.0
sum: 2    2.0 2.0 8.0
[4. 6. 8.]  

