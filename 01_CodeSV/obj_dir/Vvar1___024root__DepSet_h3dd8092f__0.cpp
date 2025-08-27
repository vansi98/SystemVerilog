// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vvar1.h for the primary calling header

#include "Vvar1__pch.h"
#include "Vvar1__Syms.h"
#include "Vvar1___024root.h"

#ifdef VL_DEBUG
VL_ATTR_COLD void Vvar1___024root___dump_triggers__act(Vvar1___024root* vlSelf);
#endif  // VL_DEBUG

void Vvar1___024root___eval_triggers__act(Vvar1___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vvar1___024root___eval_triggers__act\n"); );
    Vvar1__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__VactTriggered.setBit(0U, vlSelfRef.__VdlySched.awaitingCurrentTime());
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vvar1___024root___dump_triggers__act(vlSelf);
    }
#endif
}
