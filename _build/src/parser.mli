
(* The type of tokens. *)

type token = 
  | TVar of (string)
  | TSub
  | TRead
  | TRParen
  | TRBracket
  | TLet
  | TLParen
  | TLBracket
  | TInt of (int)
  | TEOF
  | TDefine
  | TDatatype of (Rprogram.datatype)
  | TColon
  | TAdd

(* This exception is raised by the monolithic API functions. *)

exception Error

(* The monolithic API. *)

val prog: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Rprogram.rprogram)
