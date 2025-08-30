// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Venum_method.h for the primary calling header

#ifndef VERILATED_VENUM_METHOD___024ROOT_H_
#define VERILATED_VENUM_METHOD___024ROOT_H_  // guard

#include "verilated.h"


class Venum_method__Syms;

class alignas(VL_CACHE_LINE_BYTES) Venum_method___024root final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    CData/*0:0*/ __VactContinue;
    IData/*31:0*/ __VactIterCount;
    VlTriggerVec<0> __VactTriggered;
    VlTriggerVec<0> __VnbaTriggered;

    // INTERNAL VARIABLES
    Venum_method__Syms* const vlSymsp;

    // CONSTRUCTORS
    Venum_method___024root(Venum_method__Syms* symsp, const char* v__name);
    ~Venum_method___024root();
    VL_UNCOPYABLE(Venum_method___024root);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
};


#endif  // guard
