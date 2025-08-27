// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table implementation internals

#include "Vchange_type__pch.h"
#include "Vchange_type.h"
#include "Vchange_type___024root.h"

// FUNCTIONS
Vchange_type__Syms::~Vchange_type__Syms()
{
}

Vchange_type__Syms::Vchange_type__Syms(VerilatedContext* contextp, const char* namep, Vchange_type* modelp)
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
