// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vchange_type.h for the primary calling header

#ifndef VERILATED_VCHANGE_TYPE___024ROOT_H_
#define VERILATED_VCHANGE_TYPE___024ROOT_H_  // guard

#include "verilated.h"
#include "verilated_timing.h"


class Vchange_type__Syms;

class alignas(VL_CACHE_LINE_BYTES) Vchange_type___024root final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    CData/*0:0*/ __VactContinue;
    IData/*31:0*/ change_type__DOT__i1;
    IData/*31:0*/ __VactIterCount;
    QData/*63:0*/ change_type__DOT__bit1;
    double change_type__DOT__real1;
    double change_type__DOT__real2;
    double change_type__DOT__real3;
    VlDelayScheduler __VdlySched;
    VlTriggerVec<1> __VactTriggered;
    VlTriggerVec<1> __VnbaTriggered;

    // INTERNAL VARIABLES
    Vchange_type__Syms* const vlSymsp;

    // CONSTRUCTORS
    Vchange_type___024root(Vchange_type__Syms* symsp, const char* v__name);
    ~Vchange_type___024root();
    VL_UNCOPYABLE(Vchange_type___024root);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
};


#endif  // guard
