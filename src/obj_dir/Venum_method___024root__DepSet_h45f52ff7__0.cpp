// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Venum_method.h for the primary calling header

#include "Venum_method__pch.h"
#include "Venum_method__Syms.h"
#include "Venum_method___024root.h"

#ifdef VL_DEBUG
VL_ATTR_COLD void Venum_method___024root___dump_triggers__act(Venum_method___024root* vlSelf);
#endif  // VL_DEBUG

void Venum_method___024root___eval_triggers__act(Venum_method___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Venum_method___024root___eval_triggers__act\n"); );
    Venum_method__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Venum_method___024root___dump_triggers__act(vlSelf);
    }
#endif
}
