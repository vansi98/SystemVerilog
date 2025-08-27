// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vchange_type.h for the primary calling header

#include "Vchange_type__pch.h"
#include "Vchange_type___024root.h"

VL_ATTR_COLD void Vchange_type___024root___eval_static(Vchange_type___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vchange_type___024root___eval_static\n"); );
    Vchange_type__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
}

VL_ATTR_COLD void Vchange_type___024root___eval_initial__TOP(Vchange_type___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vchange_type___024root___eval_initial__TOP\n"); );
    Vchange_type__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.change_type__DOT__real1 = 1.23549999999999997e+02;
    vlSelfRef.change_type__DOT__i1 = 0x7bU;
    vlSelfRef.change_type__DOT__real2 = 123.0;
    vlSelfRef.change_type__DOT__bit1 = 0x405ee33333333333ULL;
    vlSelfRef.change_type__DOT__real3 = 1.23549999999999997e+02;
}

VL_ATTR_COLD void Vchange_type___024root___eval_final(Vchange_type___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vchange_type___024root___eval_final\n"); );
    Vchange_type__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
}

VL_ATTR_COLD void Vchange_type___024root___eval_settle(Vchange_type___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vchange_type___024root___eval_settle\n"); );
    Vchange_type__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vchange_type___024root___dump_triggers__act(Vchange_type___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vchange_type___024root___dump_triggers__act\n"); );
    Vchange_type__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
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
VL_ATTR_COLD void Vchange_type___024root___dump_triggers__nba(Vchange_type___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vchange_type___024root___dump_triggers__nba\n"); );
    Vchange_type__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
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

VL_ATTR_COLD void Vchange_type___024root___ctor_var_reset(Vchange_type___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vchange_type___024root___ctor_var_reset\n"); );
    Vchange_type__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelf->change_type__DOT__real1 = 0;
    vlSelf->change_type__DOT__real2 = 0;
    vlSelf->change_type__DOT__real3 = 0;
    const uint64_t __VscopeHash = VL_MURMUR64_HASH(vlSelf->name());
    vlSelf->change_type__DOT__i1 = VL_SCOPED_RAND_RESET_I(32, __VscopeHash, 5239130798593103570ull);
    vlSelf->change_type__DOT__bit1 = 0;
    }
