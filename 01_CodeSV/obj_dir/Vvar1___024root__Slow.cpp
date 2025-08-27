// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vvar1.h for the primary calling header

#include "Vvar1__pch.h"
#include "Vvar1__Syms.h"
#include "Vvar1___024root.h"

void Vvar1___024root___ctor_var_reset(Vvar1___024root* vlSelf);

Vvar1___024root::Vvar1___024root(Vvar1__Syms* symsp, const char* v__name)
    : VerilatedModule{v__name}
    , __VdlySched{*symsp->_vm_contextp__}
    , vlSymsp{symsp}
 {
    // Reset structure values
    Vvar1___024root___ctor_var_reset(this);
}

void Vvar1___024root::__Vconfigure(bool first) {
    (void)first;  // Prevent unused variable warning
}

Vvar1___024root::~Vvar1___024root() {
}
