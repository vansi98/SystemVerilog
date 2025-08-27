// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vchange_type.h for the primary calling header

#include "Vchange_type__pch.h"
#include "Vchange_type___024root.h"

VL_ATTR_COLD void Vchange_type___024root___eval_initial__TOP(Vchange_type___024root* vlSelf);
VlCoroutine Vchange_type___024root___eval_initial__TOP__Vtiming__0(Vchange_type___024root* vlSelf);

void Vchange_type___024root___eval_initial(Vchange_type___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vchange_type___024root___eval_initial\n"); );
    Vchange_type__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    Vchange_type___024root___eval_initial__TOP(vlSelf);
    Vchange_type___024root___eval_initial__TOP__Vtiming__0(vlSelf);
}

VL_INLINE_OPT VlCoroutine Vchange_type___024root___eval_initial__TOP__Vtiming__0(Vchange_type___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vchange_type___024root___eval_initial__TOP__Vtiming__0\n"); );
    Vchange_type__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    co_await vlSelfRef.__VdlySched.delay(1ULL, nullptr, 
                                         "realConversion.sv", 
                                         13);
    VL_WRITEF_NX("real1 = %f real2 = %f i1=%0d\nbit1 = %b real3=%f\n",0,
                 64,vlSelfRef.change_type__DOT__real1,
                 64,vlSelfRef.change_type__DOT__real2,
                 32,vlSelfRef.change_type__DOT__i1,
                 64,vlSelfRef.change_type__DOT__bit1,
                 64,vlSelfRef.change_type__DOT__real3);
    co_await vlSelfRef.__VdlySched.delay(0xaULL, nullptr, 
                                         "realConversion.sv", 
                                         16);
    VL_FINISH_MT("realConversion.sv", 16, "");
}

void Vchange_type___024root___eval_act(Vchange_type___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vchange_type___024root___eval_act\n"); );
    Vchange_type__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
}

void Vchange_type___024root___eval_nba(Vchange_type___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vchange_type___024root___eval_nba\n"); );
    Vchange_type__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
}

void Vchange_type___024root___timing_resume(Vchange_type___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vchange_type___024root___timing_resume\n"); );
    Vchange_type__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((1ULL & vlSelfRef.__VactTriggered.word(0U))) {
        vlSelfRef.__VdlySched.resume();
    }
}

void Vchange_type___024root___eval_triggers__act(Vchange_type___024root* vlSelf);

bool Vchange_type___024root___eval_phase__act(Vchange_type___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vchange_type___024root___eval_phase__act\n"); );
    Vchange_type__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Init
    VlTriggerVec<1> __VpreTriggered;
    CData/*0:0*/ __VactExecute;
    // Body
    Vchange_type___024root___eval_triggers__act(vlSelf);
    __VactExecute = vlSelfRef.__VactTriggered.any();
    if (__VactExecute) {
        __VpreTriggered.andNot(vlSelfRef.__VactTriggered, vlSelfRef.__VnbaTriggered);
        vlSelfRef.__VnbaTriggered.thisOr(vlSelfRef.__VactTriggered);
        Vchange_type___024root___timing_resume(vlSelf);
        Vchange_type___024root___eval_act(vlSelf);
    }
    return (__VactExecute);
}

bool Vchange_type___024root___eval_phase__nba(Vchange_type___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vchange_type___024root___eval_phase__nba\n"); );
    Vchange_type__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Init
    CData/*0:0*/ __VnbaExecute;
    // Body
    __VnbaExecute = vlSelfRef.__VnbaTriggered.any();
    if (__VnbaExecute) {
        Vchange_type___024root___eval_nba(vlSelf);
        vlSelfRef.__VnbaTriggered.clear();
    }
    return (__VnbaExecute);
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vchange_type___024root___dump_triggers__nba(Vchange_type___024root* vlSelf);
#endif  // VL_DEBUG
#ifdef VL_DEBUG
VL_ATTR_COLD void Vchange_type___024root___dump_triggers__act(Vchange_type___024root* vlSelf);
#endif  // VL_DEBUG

void Vchange_type___024root___eval(Vchange_type___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vchange_type___024root___eval\n"); );
    Vchange_type__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Init
    IData/*31:0*/ __VnbaIterCount;
    CData/*0:0*/ __VnbaContinue;
    // Body
    __VnbaIterCount = 0U;
    __VnbaContinue = 1U;
    while (__VnbaContinue) {
        if (VL_UNLIKELY(((0x64U < __VnbaIterCount)))) {
#ifdef VL_DEBUG
            Vchange_type___024root___dump_triggers__nba(vlSelf);
#endif
            VL_FATAL_MT("realConversion.sv", 1, "", "NBA region did not converge.");
        }
        __VnbaIterCount = ((IData)(1U) + __VnbaIterCount);
        __VnbaContinue = 0U;
        vlSelfRef.__VactIterCount = 0U;
        vlSelfRef.__VactContinue = 1U;
        while (vlSelfRef.__VactContinue) {
            if (VL_UNLIKELY(((0x64U < vlSelfRef.__VactIterCount)))) {
#ifdef VL_DEBUG
                Vchange_type___024root___dump_triggers__act(vlSelf);
#endif
                VL_FATAL_MT("realConversion.sv", 1, "", "Active region did not converge.");
            }
            vlSelfRef.__VactIterCount = ((IData)(1U) 
                                         + vlSelfRef.__VactIterCount);
            vlSelfRef.__VactContinue = 0U;
            if (Vchange_type___024root___eval_phase__act(vlSelf)) {
                vlSelfRef.__VactContinue = 1U;
            }
        }
        if (Vchange_type___024root___eval_phase__nba(vlSelf)) {
            __VnbaContinue = 1U;
        }
    }
}

#ifdef VL_DEBUG
void Vchange_type___024root___eval_debug_assertions(Vchange_type___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vchange_type___024root___eval_debug_assertions\n"); );
    Vchange_type__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
}
#endif  // VL_DEBUG
