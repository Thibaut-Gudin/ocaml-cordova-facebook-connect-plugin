module AuthResponse : sig
  type t

  val session_key : t -> bool [@@js.get]

  val access_token : t -> string [@@js.get "accessToken"]

  val expires_in : t -> int [@@js.get "expiresIn"]

  val sig_ : t -> string [@@js.get "signedRequest"]

  val secret : t -> string [@@js.get]

  val user_id : t -> string [@@js.get "userID"]
end

type login_response

val auth_response : login_response -> AuthResponse.t option
  [@@js.get "authResponse"]

val status : login_response -> string [@@js.get]

[@@@js.stop]

module Properties : sig
  type t

  val create : (string * string) list -> t
end

type html_elt = Js_of_ocaml.Dom_html.element Js_of_ocaml.Js.t

val setAutoLogAppEventsEnabled_available : unit -> bool

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
let setAutoLogAppEventsEnabled_available () =
  Js_of_ocaml.Js.Optdef.test
    Js_of_ocaml.Js.Unsafe.global##.facebookConnectPlugin##.setAutoLogAppEventsEnabled]

module AppEvents : sig
  type t

  val log_event :
    t ->
    eventName:string ->
    ?valueToSum:float ->
    ?params:Properties.t ->
    unit ->
    unit
    [@@js.call "logEvent"]

  val log_purchase :
    t ->
    purchaseAmount:float ->
    currency:string ->
    ?params:Properties.t ->
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

val parse : xfbml -> ?dom:html_elt -> ?cb:(Ojs.t -> unit) -> unit -> unit
  [@@js.call]

type fb

val get_instance : unit -> fb [@@js.get "FB"]

val get_instance_v2 : unit -> fb [@@js.global "FB"]

val get_instance_v3 : unit -> fb [@@js.get "window.FB"]

type unity_editor_props

val unity_editor_props :
  ?appId:string ->
  ?cookie:bool ->
  ?logging:bool ->
  ?status:bool ->
  ?xfbml:bool ->
  ?version:string ->
  unit ->
  unity_editor_props
  [@@js.builder] [@@js.verbatim_names]

val init : fb -> unity_editor_props -> unit [@@js.call]

type login_opts

val login_opts :
  ?auth_type:string ->
  ?scope:string ->
  ?return_scopes:bool ->
  ?enable_profile_selector:bool ->
  ?profile_selector_ids:string ->
  unit ->
  login_opts
  [@@js.builder] [@@js.verbatim_names]

val login : fb -> ?cb:(login_response -> unit) -> login_opts -> unit [@@js.call]

type api_opts

(*TODO: find how the good type to bind the "method" parameter*)
val api :
  fb ->
  path:string ->
  method_:Ojs.t ->
  ?params:Properties.t ->
  (*See: https://developers.facebook.com/docs/graph-api/reference/ for available params values*)
  callback:(Ojs.t -> unit) ->
  unit
  [@@js.call]

val ui : fb -> params:Ojs.t -> (unit -> unit) -> unit [@@js.call]

val get_login_status : fb -> cb:(login_response -> unit) -> unit [@@js.call]

val get_app_events : fb -> AppEvents.t [@@js.get "_AppEvents"]

val get_xfbml : fb -> xfbml [@@js.get "_XFBML"]

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
    name:string ->
    ?params:Properties.t ->
    ?value:float ->
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
