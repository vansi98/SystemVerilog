// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vvar1.h for the primary calling header

#ifndef VERILATED_VVAR1___024ROOT_H_
#define VERILATED_VVAR1___024ROOT_H_  // guard

#include "verilated.h"
#include "verilated_timing.h"


class Vvar1__Syms;

class alignas(VL_CACHE_LINE_BYTES) Vvar1___024root final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    CData/*0:0*/ __VactContinue;
    IData/*31:0*/ __VactIterCount;
    VlDelayScheduler __VdlySched;
    VlTriggerVec<1> __VactTriggered;
    VlTriggerVec<1> __VnbaTriggered;

    // INTERNAL VARIABLES
    Vvar1__Syms* const vlSymsp;

    // CONSTRUCTORS
    Vvar1___024root(Vvar1__Syms* symsp, const char* v__name);
    ~Vvar1___024root();
    VL_UNCOPYABLE(Vvar1___024root);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
};


#endif  // guard
