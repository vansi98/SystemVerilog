// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table internal header
//
// Internal details; most calling programs do not need this header,
// unless using verilator public meta comments.

#ifndef VERILATED_VVAR1__SYMS_H_
#define VERILATED_VVAR1__SYMS_H_  // guard

#include "verilated.h"

// INCLUDE MODEL CLASS

#include "Vvar1.h"

// INCLUDE MODULE CLASSES
#include "Vvar1___024root.h"
#include "Vvar1___024unit.h"

// SYMS CLASS (contains all model state)
class alignas(VL_CACHE_LINE_BYTES)Vvar1__Syms final : public VerilatedSyms {
  public:
    // INTERNAL STATE
    Vvar1* const __Vm_modelp;
    VlDeleter __Vm_deleter;
    bool __Vm_didInit = false;

    // MODULE INSTANCE STATE
    Vvar1___024root                TOP;

    // CONSTRUCTORS
    Vvar1__Syms(VerilatedContext* contextp, const char* namep, Vvar1* modelp);
    ~Vvar1__Syms();

    // METHODS
    const char* name() { return TOP.name(); }
};

#endif  // guard
