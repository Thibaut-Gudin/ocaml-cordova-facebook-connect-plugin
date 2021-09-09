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

module Properties : sig
  type t

  val create : (string * string) list -> t
end

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

  (*TODO: complete the "option" type*)
  type options

  type method_ =
    | Apprequests [@js "apprequests"]
    | Feed [@js "feed"]
    | Share [@js "share"]
  [@@js.enum]

  val options :
    ?method_:method_ ->
    ?href:string ->
    ?link:string ->
    ?captation:string ->
    ?message:string ->
    unit ->
    options
    [@@js.builder] [@@js.verbatim_names]

  val show_dialog :
    t -> options -> successCB:(unit -> unit) -> faillCB:(string -> unit) -> unit
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
