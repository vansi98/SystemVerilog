// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vvar1.h for the primary calling header

#ifndef VERILATED_VVAR1___024UNIT_H_
#define VERILATED_VVAR1___024UNIT_H_  // guard

#include "verilated.h"
#include "verilated_timing.h"


class Vvar1__Syms;

class alignas(VL_CACHE_LINE_BYTES) Vvar1___024unit final : public VerilatedModule {
  public:

    // INTERNAL VARIABLES
    Vvar1__Syms* const vlSymsp;

    // CONSTRUCTORS
    Vvar1___024unit(Vvar1__Syms* symsp, const char* v__name);
    ~Vvar1___024unit();
    VL_UNCOPYABLE(Vvar1___024unit);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
};


#endif  // guard
