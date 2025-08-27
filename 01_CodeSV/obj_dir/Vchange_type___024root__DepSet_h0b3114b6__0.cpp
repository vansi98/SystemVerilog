// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vchange_type.h for the primary calling header

#include "Vchange_type__pch.h"
#include "Vchange_type__Syms.h"
#include "Vchange_type___024root.h"

#ifdef VL_DEBUG
VL_ATTR_COLD void Vchange_type___024root___dump_triggers__act(Vchange_type___024root* vlSelf);
#endif  // VL_DEBUG

void Vchange_type___024root___eval_triggers__act(Vchange_type___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vchange_type___024root___eval_triggers__act\n"); );
    Vchange_type__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__VactTriggered.setBit(0U, vlSelfRef.__VdlySched.awaitingCurrentTime());
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vchange_type___024root___dump_triggers__act(vlSelf);
    }
#endif
}
