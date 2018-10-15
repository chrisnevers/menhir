open Rprogram

let _ =
  let lex_buffer = Lexing.from_string
    "(define (add1 [x : Int] [y : Int]): Int (+ x y )) in (define (foo): Int 5) in (let ([z (read)]) z)" in
    (* "5" in *)
    (* "(define (x ): Int 4) (read)" in *)
  try
    let program = Parser.prog Lexer.token lex_buffer in
    print_endline (rprogram_str program)
  with
  | Lexer.Error ->
    let position = Lexing.lexeme_start_p lex_buffer in
    Printf.eprintf "Syntax Error (Line %d : Col %d): %s\n" position.pos_lnum position.pos_cnum (Lexing.lexeme lex_buffer)
  | Parser.Error ->
    let position = Lexing.lexeme_start_p lex_buffer in
    Printf.eprintf "Grammar Error (Line %d : Col %d): %s\n" position.pos_lnum position.pos_cnum (Lexing.lexeme lex_buffer)
