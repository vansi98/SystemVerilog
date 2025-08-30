// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table implementation internals

#include "Venum_method__pch.h"
#include "Venum_method.h"
#include "Venum_method___024root.h"

// FUNCTIONS
Venum_method__Syms::~Venum_method__Syms()
{
}

Venum_method__Syms::Venum_method__Syms(VerilatedContext* contextp, const char* namep, Venum_method* modelp)
    : VerilatedSyms{contextp}
    // Setup internal state of the Syms class
    , __Vm_modelp{modelp}
    // Setup module instances
    , TOP{this, namep}
{
        // Check resources
        Verilated::stackCheck(11);
    // Configure time unit / time precision
    _vm_contextp__->timeunit(-12);
    _vm_contextp__->timeprecision(-12);
    // Setup each module's pointers to their submodules
    // Setup each module's pointer back to symbol table (for public functions)
    TOP.__Vconfigure(true);
}
