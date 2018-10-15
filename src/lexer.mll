{
  open Rprogram
  open Parser
  exception Error
}

rule token = parse
  | [' ' '\t' 'n'] { token lexbuf }
  | "read"  { TRead }
  | "let"   { TLet }
  | "in"    { TIn }
  | "(define" { TDefine }
  | "Int"   { TDatatype Rprogram.TypeInt }
  | "Bool"  { TDatatype Rprogram.TypeBool }
  | "Void"  { TDatatype Rprogram.TypeVoid }
  | ['0'-'9']+ as i { TInt (int_of_string i) }
  | ['a'-'z''A'-'Z''0'-'9']+ as v { TVar v }
  | '(' { TLParen }
  | ')' { TRParen }
  | '[' { TLBracket }
  | ']' { TRBracket }
  | '+' { TAdd }
  | '-' { TSub }
  | ':' { TColon }
  | eof { TEOF }
  | _   { raise Error }
