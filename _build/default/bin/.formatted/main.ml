let elt_to_string elt = Fmt.str "%a" (Tyxml.Html.pp_elt ()) elt

let response2 _ =
  let open Tyxml in
  let ocaml =
    Html.(
      div
        ~a:[ a_class [ "foo" ] ]
        [ h1 [ txt "Hello, world!" ]
        ; p [ txt "This is a paragraph." ]
        ; ul [ li [ txt "This is a list item." ] ]
        ])
  in
  Dream.html @@ elt_to_string ocaml
;;

let () =
  Dream.run ~port:8888
  @@ Dream.logger
  @@ Dream.router
       [ Dream.get "/" (fun _ -> Dream.html "Good morning, world!!!")
       ; Dream.get "/echo/:word" (fun request ->
           Dream.html (Dream.param request "word"))
       ; Dream.post "/echo" (fun _ -> response2 ())
       ]
;;

(*
   let square x = x * x
let add_one x = x + 1
let successful = ref 0
let failed = ref 0

let one = 5 |> square |> add_one
let two = add_one @@ square 5
let result_one = one
let result_two = two

let condition x y=
  match (x, y) with
  | (x, y) when x = y -> "🙆"
  | _ -> "🙅"

let count_requests inner_handler request =
  try%lwt
    let%lwt response = inner_handler request in
    successful := !successful + 1;
    Lwt.return response

  with exn ->
    failed := !failed + 1;
    raise exn

let () =
  Dream.run ~port:8888
    @@ Dream.logger
    @@ count_requests 
    @@ Dream.router [

      Dream.get "/fail"
        (fun _ ->
          raise (Failure "The Web app failed!"));

      Dream.get "/"
        (fun _ -> 
          Dream.html (condition result_one result_two));  
        
      Dream.get "/hello"
        (fun _ ->
          Dream.html (Printf.sprintf "Hello world!"));

      ]
*)
