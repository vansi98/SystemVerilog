// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vvar1.h for the primary calling header

#include "Vvar1__pch.h"
#include "Vvar1___024root.h"

VL_ATTR_COLD void Vvar1___024root___eval_initial__TOP(Vvar1___024root* vlSelf);
VlCoroutine Vvar1___024root___eval_initial__TOP__Vtiming__0(Vvar1___024root* vlSelf);

void Vvar1___024root___eval_initial(Vvar1___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vvar1___024root___eval_initial\n"); );
    Vvar1__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    Vvar1___024root___eval_initial__TOP(vlSelf);
    Vvar1___024root___eval_initial__TOP__Vtiming__0(vlSelf);
}

VL_INLINE_OPT VlCoroutine Vvar1___024root___eval_initial__TOP__Vtiming__0(Vvar1___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vvar1___024root___eval_initial__TOP__Vtiming__0\n"); );
    Vvar1__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    VL_WRITEF_NX("init2. n 3\n",0);
    co_await vlSelfRef.__VdlySched.delay(0xaULL, nullptr, 
                                         "local_and_static_variabl.sv", 
                                         19);
    VL_FINISH_MT("local_and_static_variabl.sv", 19, "");
}

void Vvar1___024root___eval_act(Vvar1___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vvar1___024root___eval_act\n"); );
    Vvar1__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
}

void Vvar1___024root___eval_nba(Vvar1___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vvar1___024root___eval_nba\n"); );
    Vvar1__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
}

void Vvar1___024root___timing_resume(Vvar1___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vvar1___024root___timing_resume\n"); );
    Vvar1__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((1ULL & vlSelfRef.__VactTriggered.word(0U))) {
        vlSelfRef.__VdlySched.resume();
    }
}

void Vvar1___024root___eval_triggers__act(Vvar1___024root* vlSelf);

bool Vvar1___024root___eval_phase__act(Vvar1___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vvar1___024root___eval_phase__act\n"); );
    Vvar1__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Init
    VlTriggerVec<1> __VpreTriggered;
    CData/*0:0*/ __VactExecute;
    // Body
    Vvar1___024root___eval_triggers__act(vlSelf);
    __VactExecute = vlSelfRef.__VactTriggered.any();
    if (__VactExecute) {
        __VpreTriggered.andNot(vlSelfRef.__VactTriggered, vlSelfRef.__VnbaTriggered);
        vlSelfRef.__VnbaTriggered.thisOr(vlSelfRef.__VactTriggered);
        Vvar1___024root___timing_resume(vlSelf);
        Vvar1___024root___eval_act(vlSelf);
    }
    return (__VactExecute);
}

bool Vvar1___024root___eval_phase__nba(Vvar1___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vvar1___024root___eval_phase__nba\n"); );
    Vvar1__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Init
    CData/*0:0*/ __VnbaExecute;
    // Body
    __VnbaExecute = vlSelfRef.__VnbaTriggered.any();
    if (__VnbaExecute) {
        Vvar1___024root___eval_nba(vlSelf);
        vlSelfRef.__VnbaTriggered.clear();
    }
    return (__VnbaExecute);
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vvar1___024root___dump_triggers__nba(Vvar1___024root* vlSelf);
#endif  // VL_DEBUG
#ifdef VL_DEBUG
VL_ATTR_COLD void Vvar1___024root___dump_triggers__act(Vvar1___024root* vlSelf);
#endif  // VL_DEBUG

void Vvar1___024root___eval(Vvar1___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vvar1___024root___eval\n"); );
    Vvar1__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
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
            Vvar1___024root___dump_triggers__nba(vlSelf);
#endif
            VL_FATAL_MT("local_and_static_variabl.sv", 2, "", "NBA region did not converge.");
        }
        __VnbaIterCount = ((IData)(1U) + __VnbaIterCount);
        __VnbaContinue = 0U;
        vlSelfRef.__VactIterCount = 0U;
        vlSelfRef.__VactContinue = 1U;
        while (vlSelfRef.__VactContinue) {
            if (VL_UNLIKELY(((0x64U < vlSelfRef.__VactIterCount)))) {
#ifdef VL_DEBUG
                Vvar1___024root___dump_triggers__act(vlSelf);
#endif
                VL_FATAL_MT("local_and_static_variabl.sv", 2, "", "Active region did not converge.");
            }
            vlSelfRef.__VactIterCount = ((IData)(1U) 
                                         + vlSelfRef.__VactIterCount);
            vlSelfRef.__VactContinue = 0U;
            if (Vvar1___024root___eval_phase__act(vlSelf)) {
                vlSelfRef.__VactContinue = 1U;
            }
        }
        if (Vvar1___024root___eval_phase__nba(vlSelf)) {
            __VnbaContinue = 1U;
        }
    }
}

#ifdef VL_DEBUG
void Vvar1___024root___eval_debug_assertions(Vvar1___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vvar1___024root___eval_debug_assertions\n"); );
    Vvar1__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
}
#endif  // VL_DEBUG
