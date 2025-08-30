// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Venum_method.h for the primary calling header

#include "Venum_method__pch.h"
#include "Venum_method___024root.h"

VL_ATTR_COLD void Venum_method___024root___eval_static(Venum_method___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Venum_method___024root___eval_static\n"); );
    Venum_method__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
}

VL_ATTR_COLD void Venum_method___024root___eval_initial__TOP(Venum_method___024root* vlSelf);

VL_ATTR_COLD void Venum_method___024root___eval_initial(Venum_method___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Venum_method___024root___eval_initial\n"); );
    Venum_method__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    Venum_method___024root___eval_initial__TOP(vlSelf);
}

VL_ATTR_COLD void Venum_method___024root___eval_initial__TOP(Venum_method___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Venum_method___024root___eval_initial__TOP\n"); );
    Venum_method__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    VL_WRITEF_NX("Number of members in Colors = 3\n",0);
}

VL_ATTR_COLD void Venum_method___024root___eval_final(Venum_method___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Venum_method___024root___eval_final\n"); );
    Venum_method__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
}

VL_ATTR_COLD void Venum_method___024root___eval_settle(Venum_method___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Venum_method___024root___eval_settle\n"); );
    Venum_method__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Venum_method___024root___dump_triggers__act(Venum_method___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Venum_method___024root___dump_triggers__act\n"); );
    Venum_method__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((1U & (~ vlSelfRef.__VactTriggered.any()))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
}
#endif  // VL_DEBUG

#ifdef VL_DEBUG
VL_ATTR_COLD void Venum_method___024root___dump_triggers__nba(Venum_method___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Venum_method___024root___dump_triggers__nba\n"); );
    Venum_method__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((1U & (~ vlSelfRef.__VnbaTriggered.any()))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD void Venum_method___024root___ctor_var_reset(Venum_method___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Venum_method___024root___ctor_var_reset\n"); );
    Venum_method__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
}
