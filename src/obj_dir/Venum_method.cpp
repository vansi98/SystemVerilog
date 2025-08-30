// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Model implementation (design independent parts)

#include "Venum_method__pch.h"

//============================================================
// Constructors

Venum_method::Venum_method(VerilatedContext* _vcontextp__, const char* _vcname__)
    : VerilatedModel{*_vcontextp__}
    , vlSymsp{new Venum_method__Syms(contextp(), _vcname__, this)}
    , rootp{&(vlSymsp->TOP)}
{
    // Register model with the context
    contextp()->addModel(this);
}

Venum_method::Venum_method(const char* _vcname__)
    : Venum_method(Verilated::threadContextp(), _vcname__)
{
}

//============================================================
// Destructor

Venum_method::~Venum_method() {
    delete vlSymsp;
}

//============================================================
// Evaluation function

#ifdef VL_DEBUG
void Venum_method___024root___eval_debug_assertions(Venum_method___024root* vlSelf);
#endif  // VL_DEBUG
void Venum_method___024root___eval_static(Venum_method___024root* vlSelf);
void Venum_method___024root___eval_initial(Venum_method___024root* vlSelf);
void Venum_method___024root___eval_settle(Venum_method___024root* vlSelf);
void Venum_method___024root___eval(Venum_method___024root* vlSelf);

void Venum_method::eval_step() {
    VL_DEBUG_IF(VL_DBG_MSGF("+++++TOP Evaluate Venum_method::eval_step\n"); );
#ifdef VL_DEBUG
    // Debug assertions
    Venum_method___024root___eval_debug_assertions(&(vlSymsp->TOP));
#endif  // VL_DEBUG
    vlSymsp->__Vm_deleter.deleteAll();
    if (VL_UNLIKELY(!vlSymsp->__Vm_didInit)) {
        vlSymsp->__Vm_didInit = true;
        VL_DEBUG_IF(VL_DBG_MSGF("+ Initial\n"););
        Venum_method___024root___eval_static(&(vlSymsp->TOP));
        Venum_method___024root___eval_initial(&(vlSymsp->TOP));
        Venum_method___024root___eval_settle(&(vlSymsp->TOP));
    }
    VL_DEBUG_IF(VL_DBG_MSGF("+ Eval\n"););
    Venum_method___024root___eval(&(vlSymsp->TOP));
    // Evaluate cleanup
    Verilated::endOfEval(vlSymsp->__Vm_evalMsgQp);
}

//============================================================
// Events and timing
bool Venum_method::eventsPending() { return false; }

uint64_t Venum_method::nextTimeSlot() {
    VL_FATAL_MT(__FILE__, __LINE__, "", "No delays in the design");
    return 0;
}

//============================================================
// Utilities

const char* Venum_method::name() const {
    return vlSymsp->name();
}

//============================================================
// Invoke final blocks

void Venum_method___024root___eval_final(Venum_method___024root* vlSelf);

VL_ATTR_COLD void Venum_method::final() {
    Venum_method___024root___eval_final(&(vlSymsp->TOP));
}

//============================================================
// Implementations of abstract methods from VerilatedModel

const char* Venum_method::hierName() const { return vlSymsp->name(); }
const char* Venum_method::modelName() const { return "Venum_method"; }
unsigned Venum_method::threads() const { return 1; }
void Venum_method::prepareClone() const { contextp()->prepareClone(); }
void Venum_method::atClone() const {
    contextp()->threadPoolpOnClone();
}
