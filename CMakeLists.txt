cmake_minimum_required(VERSION 3.14)
find_package(CUDA REQUIRED)
find_package(PythonInterp 3.8 REQUIRED)
find_package(PythonLibs 3.8 REQUIRED)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
set(LIBRARY_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/)

include_directories(
	${PYTHON_INCLUDE_DIRS}
	./src
)

link_directories(/usr/local/cuda-11.4/lib64)

cuda_add_library(cuda_plugin SHARED
	src/add.cu
	src/main.cpp
)

target_link_libraries(cuda_plugin
	${PYTHON_LIBRARIES}
	cudart
)

set_target_properties(cuda_plugin PROPERTIES PREFIX "")
