// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vvar1.h for the primary calling header

#include "Vvar1__pch.h"
#include "Vvar1___024root.h"

VL_ATTR_COLD void Vvar1___024root___eval_static(Vvar1___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vvar1___024root___eval_static\n"); );
    Vvar1__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
}

VL_ATTR_COLD void Vvar1___024root___eval_initial__TOP(Vvar1___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vvar1___024root___eval_initial__TOP\n"); );
    Vvar1__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    VL_WRITEF_NX("module level n = 2\nblock level n = 3\nstatic n = 4\n",0);
}

VL_ATTR_COLD void Vvar1___024root___eval_final(Vvar1___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vvar1___024root___eval_final\n"); );
    Vvar1__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
}

VL_ATTR_COLD void Vvar1___024root___eval_settle(Vvar1___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vvar1___024root___eval_settle\n"); );
    Vvar1__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vvar1___024root___dump_triggers__act(Vvar1___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vvar1___024root___dump_triggers__act\n"); );
    Vvar1__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((1U & (~ vlSelfRef.__VactTriggered.any()))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if ((1ULL & vlSelfRef.__VactTriggered.word(0U))) {
        VL_DBG_MSGF("         'act' region trigger index 0 is active: @([true] __VdlySched.awaitingCurrentTime())\n");
    }
}
#endif  // VL_DEBUG

#ifdef VL_DEBUG
VL_ATTR_COLD void Vvar1___024root___dump_triggers__nba(Vvar1___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vvar1___024root___dump_triggers__nba\n"); );
    Vvar1__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((1U & (~ vlSelfRef.__VnbaTriggered.any()))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if ((1ULL & vlSelfRef.__VnbaTriggered.word(0U))) {
        VL_DBG_MSGF("         'nba' region trigger index 0 is active: @([true] __VdlySched.awaitingCurrentTime())\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD void Vvar1___024root___ctor_var_reset(Vvar1___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vvar1___024root___ctor_var_reset\n"); );
    Vvar1__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    }
