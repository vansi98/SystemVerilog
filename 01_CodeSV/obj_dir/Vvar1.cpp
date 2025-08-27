// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Model implementation (design independent parts)

#include "Vvar1__pch.h"

//============================================================
// Constructors

Vvar1::Vvar1(VerilatedContext* _vcontextp__, const char* _vcname__)
    : VerilatedModel{*_vcontextp__}
    , vlSymsp{new Vvar1__Syms(contextp(), _vcname__, this)}
    , rootp{&(vlSymsp->TOP)}
{
    // Register model with the context
    contextp()->addModel(this);
}

Vvar1::Vvar1(const char* _vcname__)
    : Vvar1(Verilated::threadContextp(), _vcname__)
{
}

//============================================================
// Destructor

Vvar1::~Vvar1() {
    delete vlSymsp;
}

//============================================================
// Evaluation function

#ifdef VL_DEBUG
void Vvar1___024root___eval_debug_assertions(Vvar1___024root* vlSelf);
#endif  // VL_DEBUG
void Vvar1___024root___eval_static(Vvar1___024root* vlSelf);
void Vvar1___024root___eval_initial(Vvar1___024root* vlSelf);
void Vvar1___024root___eval_settle(Vvar1___024root* vlSelf);
void Vvar1___024root___eval(Vvar1___024root* vlSelf);

void Vvar1::eval_step() {
    VL_DEBUG_IF(VL_DBG_MSGF("+++++TOP Evaluate Vvar1::eval_step\n"); );
#ifdef VL_DEBUG
    // Debug assertions
    Vvar1___024root___eval_debug_assertions(&(vlSymsp->TOP));
#endif  // VL_DEBUG
    vlSymsp->__Vm_deleter.deleteAll();
    if (VL_UNLIKELY(!vlSymsp->__Vm_didInit)) {
        vlSymsp->__Vm_didInit = true;
        VL_DEBUG_IF(VL_DBG_MSGF("+ Initial\n"););
        Vvar1___024root___eval_static(&(vlSymsp->TOP));
        Vvar1___024root___eval_initial(&(vlSymsp->TOP));
        Vvar1___024root___eval_settle(&(vlSymsp->TOP));
    }
    VL_DEBUG_IF(VL_DBG_MSGF("+ Eval\n"););
    Vvar1___024root___eval(&(vlSymsp->TOP));
    // Evaluate cleanup
    Verilated::endOfEval(vlSymsp->__Vm_evalMsgQp);
}

//============================================================
// Events and timing
bool Vvar1::eventsPending() { return !vlSymsp->TOP.__VdlySched.empty(); }

uint64_t Vvar1::nextTimeSlot() { return vlSymsp->TOP.__VdlySched.nextTimeSlot(); }

//============================================================
// Utilities

const char* Vvar1::name() const {
    return vlSymsp->name();
}

//============================================================
// Invoke final blocks

void Vvar1___024root___eval_final(Vvar1___024root* vlSelf);

VL_ATTR_COLD void Vvar1::final() {
    Vvar1___024root___eval_final(&(vlSymsp->TOP));
}

//============================================================
// Implementations of abstract methods from VerilatedModel

const char* Vvar1::hierName() const { return vlSymsp->name(); }
const char* Vvar1::modelName() const { return "Vvar1"; }
unsigned Vvar1::threads() const { return 1; }
void Vvar1::prepareClone() const { contextp()->prepareClone(); }
void Vvar1::atClone() const {
    contextp()->threadPoolpOnClone();
}
