type auth_response

val session_key : auth_response -> bool [@@js.get]

val acess_token : auth_response -> string [@@js.get "acessToken"]

val expires_in : auth_response -> int [@@js.get "expiresIn"]

val sig_ : auth_response -> string [@@js.get "signedRequest"]

val secret : auth_response -> string [@@js.get]

val user_id : auth_response -> string [@@js.get "userID"]

type login_response

val auth_response : login_response -> auth_response option
  [@@js.get "authResponse"]

val status : login_response -> string [@@js.get]

[@@@js.stop]

module Properties : sig
  type t

  val create : (string * string) list -> t
end

type html_elt = Js_of_ocaml.Dom_html.element Js_of_ocaml.Js.t

val setAutoLogAppEventEnabled_available : unit -> bool

[@@@js.start]

[@@@js.implem
module Properties = struct
  type t = Ojs.t

  let create ls =
    Ojs.obj
      (Array.of_list (List.map (fun (k, v) -> (k, Ojs.string_to_js v)) ls))

  let t_to_js x = Ojs.t_to_js x
end]

[@@@js.implem type html_elt = Js_of_ocaml.Dom_html.element Js_of_ocaml.Js.t]

[@@@js.implem let html_elt_to_js = Obj.magic]

[@@@js.implem
let setAutoLogAppEventEnabled_available () =
  Js_of_ocaml.Js.Optdef.test
    Js_of_ocaml.Js.Unsafe.global##.facebookConnectPlugin##.setAutoLogAppEventsEnabled]

module AppEvents : sig
  type t

  val log_event :
    t ->
    eventName:string ->
    ?valueToSum:float ->
    ?param:Properties.t ->
    unit ->
    unit
    [@@js.call "logEvent"]

  val log_purchase :
    t ->
    purchaseAmount:float ->
    currency:string ->
    ?param:Properties.t ->
    unit ->
    unit
    [@@js.call "logPurchase"]

  val activate_app : t -> unit [@@js.call "activate_app"]

  val log_page_view : t -> unit [@@js.call "logPageView"]

  val set_user_id : t -> userID:string -> unit [@@js.call "setUserID"]

  val get_user_id : t -> string [@@js.call "getUserID"]

  val clear_user_id : t -> unit [@@js.call "clearUserID"]

  val update_user_properties :
    t -> params:string * string -> cb:(unit -> unit) -> unit
    [@@js.call "updateUserProperties"]

  val set_app_version : t -> string -> unit [@@js.call "setAppVersion"]

  val get_app_version : t -> string [@@js.call "getAppVersion"]

  val clear_app_version : t -> unit [@@js.call "clearAppVersion"]
end

type xfbml

val parse : xfbml -> html_elt -> unit [@@js.call]

module ConnectPlugin : sig
  type t

  val get_instance : unit -> t [@@js.get "facebookConnectPlugin"]

  val get_instance_v2 : unit -> t [@@js.get "window._facebookConnectPlugin"]

  val browser_init : t -> Ojs.t -> unit [@@js.call "BrowserInit"]

  val logout : t -> successCB:(unit -> unit) -> faillCB:(string -> unit) -> unit
    [@@js.call]

  val login :
    t ->
    string array ->
    successCB:(login_response -> unit) ->
    faillCB:(string -> unit) ->
    unit
    [@@js.call]

  val get_login_status :
    t -> successCB:(login_response -> unit) -> faillCB:(string -> unit) -> unit
    [@@js.call "getLoginStatus"]

  type method_ =
    | Apprequests [@js "apprequests"]
    | Feed [@js "feed"]
    | Share [@js "share"]
  [@@js.enum]

  (*TODO: complete the "opts" type*)
  type opts

  val opts :
    ?method_:method_ ->
    ?href:string ->
    ?link:string ->
    ?captation:string ->
    ?message:string ->
    unit ->
    opts
    [@@js.builder] [@@js.verbatim_names]

  val show_dialog :
    t -> opts -> successCB:(unit -> unit) -> faillCB:(string -> unit) -> unit
    [@@js.call "showDialog"]

  (*TODO: find the first parameter type*)
  val app_invite :
    t -> Ojs.t -> successCB:(unit -> unit) -> failCB:(string -> unit) -> unit
    [@@js.call]

  val log_event :
    t ->
    string ->
    ?parms:Properties.t ->
    float ->
    successCB:(unit -> unit) ->
    faillCB:(string -> unit) ->
    unit
    [@@js.call "logEvent"]

  val log_purchase :
    t ->
    float ->
    string ->
    successCB:(unit -> unit) ->
    faillCB:(string -> unit) ->
    unit
    [@@js.call "logPurchase"]

  val set_auto_log_app_events_enabled :
    t -> bool -> successCB:(unit -> unit) -> faillCB:(unit -> unit) -> unit
    [@@js.call "setAutoLogAppEventsEnabled"]
end
