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

type fb_cordova

val get_instance : unit -> fb_cordova [@@js.get "facebookConnectPlugin"]

val get_instance_v2 : unit -> fb_cordova
  [@@js.get "window._facebookConnectPlugin"]

val browser_init : fb_cordova -> Ojs.t -> unit [@@js.call "BrowserInit"]

val logout :
  fb_cordova -> successCB:(unit -> unit) -> faillCB:(string -> unit) -> unit
  [@@js.call]

val login :
  fb_cordova ->
  string array ->
  successCB:(login_response -> unit) ->
  faillCB:(string -> unit) ->
  unit
  [@@js.call]

val get_login_status :
  fb_cordova ->
  successCB:(login_response -> unit) ->
  faillCB:(string -> unit) ->
  unit
  [@@js.call "getLoginStatus"]

(*TODO: crete an "option" type for the first argument*)
val show_dialog :
  fb_cordova ->
  Ojs.t ->
  successCB:(unit -> unit) ->
  faillCB:(string -> unit) ->
  unit
  [@@js.call "showDialog"]

(*TODO: find the first parameter type*)
val app_invite :
  fb_cordova ->
  Ojs.t ->
  successCB:(unit -> unit) ->
  failCB:(string -> unit) ->
  unit
  [@@js.call]

(*TODO: is Ojs.t an adapted type?, it need an object type..*)
val log_event :
  fb_cordova ->
  string ->
  ?parms:Ojs.t ->
  float ->
  successCB:(unit -> unit) ->
  faillCB:(string -> unit) ->
  unit
  [@@js.call "logEvent"]

val log_purchase :
  fb_cordova ->
  float ->
  string ->
  successCB:(unit -> unit) ->
  faillCB:(string -> unit) ->
  unit
  [@@js.call "logPurchase"]

val set_auto_log_app_events_enabled :
  fb_cordova ->
  bool ->
  successCB:(unit -> unit) ->
  faillCB:(unit -> unit) ->
  unit
  [@@js.call "setAutoLogAppEventsEnabled"]
