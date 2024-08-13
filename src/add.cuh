#ifndef ADD_H
#define ADD_H

#ifdef _WIN32
    // Windows-specific code here
extern "C" __declspec(dllexport) void vectorAdd(double c[], double a[], double b[], int size);
#else
    // Linux or other platform-specific code here
extern "C"  void vectorAdd(double c[], double a[], double b[], int size);
#endif

#endif

