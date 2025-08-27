// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vvar1.h for the primary calling header

#include "Vvar1__pch.h"
#include "Vvar1__Syms.h"
#include "Vvar1___024unit.h"

void Vvar1___024unit___ctor_var_reset(Vvar1___024unit* vlSelf);

Vvar1___024unit::Vvar1___024unit(Vvar1__Syms* symsp, const char* v__name)
    : VerilatedModule{v__name}
    , vlSymsp{symsp}
 {
    // Reset structure values
    Vvar1___024unit___ctor_var_reset(this);
}

void Vvar1___024unit::__Vconfigure(bool first) {
    (void)first;  // Prevent unused variable warning
}

Vvar1___024unit::~Vvar1___024unit() {
}
