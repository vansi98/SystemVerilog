// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Model implementation (design independent parts)

#include "Vchange_type__pch.h"

//============================================================
// Constructors

Vchange_type::Vchange_type(VerilatedContext* _vcontextp__, const char* _vcname__)
    : VerilatedModel{*_vcontextp__}
    , vlSymsp{new Vchange_type__Syms(contextp(), _vcname__, this)}
    , rootp{&(vlSymsp->TOP)}
{
    // Register model with the context
    contextp()->addModel(this);
}

Vchange_type::Vchange_type(const char* _vcname__)
    : Vchange_type(Verilated::threadContextp(), _vcname__)
{
}

//============================================================
// Destructor

Vchange_type::~Vchange_type() {
    delete vlSymsp;
}

//============================================================
// Evaluation function

#ifdef VL_DEBUG
void Vchange_type___024root___eval_debug_assertions(Vchange_type___024root* vlSelf);
#endif  // VL_DEBUG
void Vchange_type___024root___eval_static(Vchange_type___024root* vlSelf);
void Vchange_type___024root___eval_initial(Vchange_type___024root* vlSelf);
void Vchange_type___024root___eval_settle(Vchange_type___024root* vlSelf);
void Vchange_type___024root___eval(Vchange_type___024root* vlSelf);

void Vchange_type::eval_step() {
    VL_DEBUG_IF(VL_DBG_MSGF("+++++TOP Evaluate Vchange_type::eval_step\n"); );
#ifdef VL_DEBUG
    // Debug assertions
    Vchange_type___024root___eval_debug_assertions(&(vlSymsp->TOP));
#endif  // VL_DEBUG
    vlSymsp->__Vm_deleter.deleteAll();
    if (VL_UNLIKELY(!vlSymsp->__Vm_didInit)) {
        vlSymsp->__Vm_didInit = true;
        VL_DEBUG_IF(VL_DBG_MSGF("+ Initial\n"););
        Vchange_type___024root___eval_static(&(vlSymsp->TOP));
        Vchange_type___024root___eval_initial(&(vlSymsp->TOP));
        Vchange_type___024root___eval_settle(&(vlSymsp->TOP));
    }
    VL_DEBUG_IF(VL_DBG_MSGF("+ Eval\n"););
    Vchange_type___024root___eval(&(vlSymsp->TOP));
    // Evaluate cleanup
    Verilated::endOfEval(vlSymsp->__Vm_evalMsgQp);
}

//============================================================
// Events and timing
bool Vchange_type::eventsPending() { return !vlSymsp->TOP.__VdlySched.empty(); }

uint64_t Vchange_type::nextTimeSlot() { return vlSymsp->TOP.__VdlySched.nextTimeSlot(); }

//============================================================
// Utilities

const char* Vchange_type::name() const {
    return vlSymsp->name();
}

//============================================================
// Invoke final blocks

void Vchange_type___024root___eval_final(Vchange_type___024root* vlSelf);

VL_ATTR_COLD void Vchange_type::final() {
    Vchange_type___024root___eval_final(&(vlSymsp->TOP));
}

//============================================================
// Implementations of abstract methods from VerilatedModel

const char* Vchange_type::hierName() const { return vlSymsp->name(); }
const char* Vchange_type::modelName() const { return "Vchange_type"; }
unsigned Vchange_type::threads() const { return 1; }
void Vchange_type::prepareClone() const { contextp()->prepareClone(); }
void Vchange_type::atClone() const {
    contextp()->threadPoolpOnClone();
}
