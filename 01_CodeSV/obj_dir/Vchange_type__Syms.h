// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table internal header
//
// Internal details; most calling programs do not need this header,
// unless using verilator public meta comments.

#ifndef VERILATED_VCHANGE_TYPE__SYMS_H_
#define VERILATED_VCHANGE_TYPE__SYMS_H_  // guard

#include "verilated.h"

// INCLUDE MODEL CLASS

#include "Vchange_type.h"

// INCLUDE MODULE CLASSES
#include "Vchange_type___024root.h"

// SYMS CLASS (contains all model state)
class alignas(VL_CACHE_LINE_BYTES)Vchange_type__Syms final : public VerilatedSyms {
  public:
    // INTERNAL STATE
    Vchange_type* const __Vm_modelp;
    VlDeleter __Vm_deleter;
    bool __Vm_didInit = false;

    // MODULE INSTANCE STATE
    Vchange_type___024root         TOP;

    // CONSTRUCTORS
    Vchange_type__Syms(VerilatedContext* contextp, const char* namep, Vchange_type* modelp);
    ~Vchange_type__Syms();

    // METHODS
    const char* name() { return TOP.name(); }
};

#endif  // guard
