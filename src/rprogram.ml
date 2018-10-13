open Core

type datatype =
  | TypeInt
  | TypeBool
  | TypeVoid
  [@@deriving sexp]

let datatype_str d = sexp_of_datatype d |> Sexp.to_string_hum

type rexp =
  | RInt of int
  | RVar of string
  | RRead
  | RUnop of string * rexp
  | RBinop of string * rexp * rexp
  | RLet of string * rexp * rexp
  [@@deriving sexp]

let rexp_str e = sexp_of_rexp e |> Sexp.to_string_hum

type rdefine =
  | RDefine of string * (rexp * datatype) list * datatype * rexp
  [@@deriving sexp]

let rdefine_str d = sexp_of_rdefine d |> Sexp.to_string_hum

type rprogram =
  | RProgram of rdefine list * rexp
  [@@deriving sexp]

let rprogram_str p = sexp_of_rprogram p |> Sexp.to_string_hum

