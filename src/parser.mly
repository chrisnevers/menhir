%{
  open Rprogram
%}

%token <int> TInt
%token <string> TVar
%token <Rprogram.datatype> TDatatype
%token TRead
%token TLet
%token TIn
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
  | e = expr { RProgram ([], e) }
  | defs = defs; e = expr; TEOF { RProgram (defs, e) }
  ;

defs:
  | d = def; tl = defs; { d :: tl }
  | { [] }
  ;

def:
  | TDefine; TLParen; id = TVar; a = args;
    TRParen; TColon; dt = TDatatype; e = expr; TRParen; TIn;
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
  | TLParen; e = inner_expr; TRParen
      { e }

inner_expr:
  | TRead
      { RRead }
  | TLet; TLParen; TLBracket; id = TVar; ie = expr;
    TRBracket; TRParen; be = expr
      { RLet (id, ie, be) }
  | TAdd; e = expr
      { RUnop ("+", e) }
  | TSub; e = expr
      { RUnop ("-", e) }
  | TAdd; l = expr; r = expr
      { RBinop ("+", l, r) }
  | TSub; l = expr; r = expr
      { RBinop ("-", l, r) }
  ;

/* prog:
  | e = expr { RProgram ([], e) }
  | TLParen; p = program { p }
  ;

program:
  | defs = defs; e = expr; TEOF { RProgram (defs, e) }
  ;

defs:
  | d = def { [d] }
  | d = def; tl = defs; TRParen { d :: tl }
  comment | { [] }
  ;

def:
  | TDefine; TLParen; id = TVar; a = args;
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
  | TLParen; e = inner_expr; TRParen
      { e }

inner_expr:
  | TRead
      { RRead }
  | TLet; TLParen; TLBracket; id = TVar; ie = expr;
    TRBracket; TRParen; be = expr
      { RLet (id, ie, be) }
  | TAdd; e = expr
      { RUnop ("+", e) }
  | TSub; e = expr
      { RUnop ("-", e) }
  | TAdd; l = expr; r = expr
      { RBinop ("+", l, r) }
  | TSub; l = expr; r = expr
      { RBinop ("-", l, r) }
  ;
 */