%{
  open Rprogram
%}

%token <int> TInt
%token <string> TVar
%token <Rprogram.datatype> TDatatype
%token TRead
%token TLet
%token TAdd
%token TSub
%token TLParen
%token TRParen
%token TLBracket
%token TRBracket
%token TDefine
%token TColon
%token TEOF

%start <Rprogram.rprogram> prog

%%

prog:
  | defs = defs; e = expr; TEOF { RProgram (defs, e) }
  ;

defs:
  | d = def; tl = defs { d :: tl }
  | { [] }
  ;

def:
  | TLParen; TDefine; TLParen; id = TVar; a = args;
    TRParen; TColon; dt = TDatatype; e = expr; TRParen
      { RDefine (id, a, dt, e) }
  ;

args:
  | a = arg; tl = args { a :: tl }
  | { [] }
  ;

arg:
  | TLBracket; id = TVar; TColon; dt = TDatatype; TRBracket
      { (RVar id, dt) }
  ;

expr:
  | i = TInt
      { RInt i }
  | id = TVar
      { RVar id }
  | TLParen; TRead; TRParen
      { RRead }
  | TLParen; TLet; TLParen; TLBracket; id = TVar; ie = expr;
    TRBracket; TRParen; be = expr; TRParen
      { RLet (id, ie, be) }
  | TLParen; TAdd; e = expr; TRParen
      { RUnop ("+", e) }
  | TLParen; TSub; e = expr; TRParen
      { RUnop ("-", e) }
  | TLParen; TAdd; l = expr; r = expr; TRParen
      { RBinop ("+", l, r) }
  | TLParen; TSub; l = expr; r = expr; TRParen
      { RBinop ("-", l, r) }
  ;
