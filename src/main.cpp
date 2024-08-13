#include<pybind11/pybind11.h>
#include<pybind11/numpy.h>
#include<stdio.h>
#include<cstring>
#include "add.cuh"

namespace py = pybind11;

int add(int i, int j)
{
	return i + j;
}

py::array_t<double> vectorAdd1(py::array_t<double>& arr_a, py::array_t<double>& arr_b)
{

	py::buffer_info bufA = arr_a.request(), bufB = arr_b.request();

	const int w = bufA.shape[1];
	py::print("result_shape w=", w);
	
	auto result = py::array_t<double>(w);

	py::buffer_info bufResult = result.request();
	
	double* ptrA = (double*)bufA.ptr;
	double* ptrB = (double*)bufB.ptr;
	double* ptrResult = (double*)bufResult.ptr;  //获得数据指针


	
	//printf("Buffer A: \n");
	//for (int i = 0; i < w; i++) {
	//    printf("%.2f ", ptrA[i]);
	//}
	//printf("\n");

	//printf("Buffer B: \n");
	//for (int i = 0; i < w; i++) {
	//    printf("%.2f ", ptrB[i]);
	//}
	//printf("\n");
	
	vectorAdd(ptrResult, ptrA, ptrB, w);

	for (int i = 0; i < w; ++i)
		py::print("sum:", i, "  ", ptrA, ptrB, ptrResult[i]);

	return result;
}

PYBIND11_MODULE(cuda_plugin, m) {
	m.doc() = "pybind11 cuda example plugin"; // optional module docstring

	m.def("add", &add, "A function that adds two numbers");
	m.def("vectorAdd1", &vectorAdd1, "A function that adds two ");
}

