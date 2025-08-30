// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table internal header
//
// Internal details; most calling programs do not need this header,
// unless using verilator public meta comments.

#ifndef VERILATED_VENUM_METHOD__SYMS_H_
#define VERILATED_VENUM_METHOD__SYMS_H_  // guard

#include "verilated.h"

// INCLUDE MODEL CLASS

#include "Venum_method.h"

// INCLUDE MODULE CLASSES
#include "Venum_method___024root.h"

// SYMS CLASS (contains all model state)
class alignas(VL_CACHE_LINE_BYTES)Venum_method__Syms final : public VerilatedSyms {
  public:
    // INTERNAL STATE
    Venum_method* const __Vm_modelp;
    VlDeleter __Vm_deleter;
    bool __Vm_didInit = false;

    // MODULE INSTANCE STATE
    Venum_method___024root         TOP;

    // CONSTRUCTORS
    Venum_method__Syms(VerilatedContext* contextp, const char* namep, Venum_method* modelp);
    ~Venum_method__Syms();

    // METHODS
    const char* name() { return TOP.name(); }
};

#endif  // guard
