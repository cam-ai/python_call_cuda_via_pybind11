#include "cuda_runtime.h"  
#include "device_launch_parameters.h"    
#include "stdio.h"
#include "add.cuh"
//CUDA核函数
__global__ void addKernel(double* c, const double* a, const double* b)
{
	int i = threadIdx.x;
	c[i] = a[i] + b[i];
}
// 向量相加
void vectorAdd(double c[], double a[], double b[],int size)
{
	double* dev_a = 0;
	double* dev_b = 0;
	double* dev_c = 0;

	//printf("GPU A: \n");
	//for (int i = 0; i < size; i++) {
	//    printf("%.2f ", a[i]);
	//}
	//printf("\n");

	//printf("GPU B: \n");
	//for (int i = 0; i < size; i++) {
	//    printf("%.2f ", b[i]);
	//}
	//printf("\n");
	
	// 在GPU中为变量dev_a、dev_b、dev_c分配内存空间.  
	cudaMalloc((void**)&dev_c, size * sizeof(double));
	cudaMalloc((void**)&dev_a, size * sizeof(double));
	cudaMalloc((void**)&dev_b, size * sizeof(double));

	// 从主机内存复制数据到GPU内存中.  
	cudaMemcpy(dev_a, a, size * sizeof(double), cudaMemcpyHostToDevice);
	cudaMemcpy(dev_b, b, size * sizeof(double), cudaMemcpyHostToDevice);

	// 启动GPU内核函数  
	addKernel <<<1, size >>> (dev_c, dev_a, dev_b);

	// 采用cudaDeviceSynchronize等待GPU内核函数执行完成并且返回遇到的任何错误信息  
	cudaDeviceSynchronize();

	// 从GPU内存中复制数据到主机内存中  
	cudaMemcpy(c, dev_c, size * sizeof(double), cudaMemcpyDeviceToHost);

	//printf("GPU C: \n");
	//for (int i = 0; i < size; i++) {
	//    printf("%.2f ", c[i]);
	//}
	//printf("\n");
	
	//释放设备中变量所占内存  
	cudaFree(dev_c);
	cudaFree(dev_a);
	cudaFree(dev_b);

	return ;
}
