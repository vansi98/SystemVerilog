// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vchange_type.h for the primary calling header

#include "Vchange_type__pch.h"
#include "Vchange_type__Syms.h"
#include "Vchange_type___024root.h"

void Vchange_type___024root___ctor_var_reset(Vchange_type___024root* vlSelf);

Vchange_type___024root::Vchange_type___024root(Vchange_type__Syms* symsp, const char* v__name)
    : VerilatedModule{v__name}
    , __VdlySched{*symsp->_vm_contextp__}
    , vlSymsp{symsp}
 {
    // Reset structure values
    Vchange_type___024root___ctor_var_reset(this);
}

void Vchange_type___024root::__Vconfigure(bool first) {
    (void)first;  // Prevent unused variable warning
}

Vchange_type___024root::~Vchange_type___024root() {
}
