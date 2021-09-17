# ocaml-cordova-facebook-plugin
ocaml binding to the Javascript plugins `facebookConnectPlugin` and `FB` using gen_js_api

# What does ocaml-cordova-facebook-connect-plugin do ?

This library allow you to use sevral *Facebook* Java Script plugins
into your ocaml app:

The `FB` plugin, allow you to use sevral *Facebook* functionnalities
into your app.

The `facebookConnectPlugin` plugin, like it's name suggest,allow a user
to connect to your app ussing a *Facebook* account.

Binding to
[facebbokConnectPlugin-angular](https://github.com/dunksmith/facebookConnectPlugin-angular)
using gen_js_api.

## How to install and compile your project by using this plugin ?

You can use opam by pining the repository with:
```Shell
opam pin add facebook-connect-plugin https://github.com/besport/ocaml-cordova-facebook-connect-plugin
```

to compile your project, use:
```Shell
dune build @install
```

Finally, install the "facebook-connect-plugin" plugin with
```Shell
cordova plugin add facebook-connect-plugin
```

## How to use it?

See the [facebook for developers official
documentation](https://developers.facebook.com/?no_redirect=1) for more details.

### The `Fb.set_fb_async_init` function

> The function assigned to window.fbAsyncInit is run as soon as the SDK
  has completed loading. Any code that you want to run after the SDK is
  loaded should be placed within this function and after the call to
  FB.init. Any kind of JavaScript can be used here, but any SDK
  functions must be called after FB.init.

  Source : [facebook oficial
  documentation](https://developers.facebook.com/docs/javascript/advanced-setup)

This function allows you to set the value of the current `fbAsyncInit`
function in you application.

### The `ConnectPlugin` module

This module do the binding to the `facebookConnectPlugin` plugin.

See the [faceboock official
documentation](https://github.com/Wizcorp/phonegap-facebook-plugin/) for
more details.

### Some typing presentation

Their is a lot of specific typing for the functions of this plugin, some
of thoses type are part of a given module that grand access to several
data, so using thoses modules is required if you want to fully exploit
the result of all the function.

This section will give a quick tour of some of thoses specifics typing,
you can see the `fb.mli` file for a more exaustive list of available
data in addition to the  [facebook for developers official
documentation](https://developers.facebook.com/?no_redirect=1).

#### `AuthResponse`

This module define the *AuthResponse* type that can be obtain for a
`login_response` with the `Fb.auth_response` function. This module
grant access to several data of this type.

#### The `login_response` type

This type is use as parametera for several callback arguments of
functions `login` and `get_login_status`. Their is 2 data that can be
obtains from a `login_response` data: the `Fb.auth_response` data (that
we already cover) and the `Fb.status` (a string value).

#### The `Properties` module

This module devine a type that is use in several function of this
module, mainly the `log` functions.

The type `Properties.t` is an associative array of properties to store
(for example {'Name': 'Value', 'Age' : '22'}), you can create a
`Properties.t` value with the function `Properties.create` that convert
a liste of (string * string) into a `Properties.t` object
Example:
```Ocaml
let props = [("Name", "Value");("Age", "22")] in
let properties = FB.Properties.create props
```

#### What is a `html_element` value ?

Some function can take a value of type `html_element` like the
`Fb.parse` function. It is a value of type `Dom_html.element Js.t` from
the `Js_of_ocaml` library. You can see more details about this type in
the [Js_of_ocaml official
documentation](https://ocsigen.org/js_of_ocaml/3.1.0/api/Dom_html.element-c). You
can obtains that kind of values with functions like
`Eliom_content.Html.TO_dom.of_element`, see the [official
documentation](https://ocsigen.org/js_of_ocaml/latest/api/js_of_ocaml-tyxml/Js_of_ocaml_tyxml/Tyxml_cast_sigs/module-type-OF/index.html)
for more details.

#### The `AppEvents` module

This module contains several function that can be use with an
`AppEvent`, a value that you can obtains with the `Fb.get_app_events`
function. Their is several usefull function that you can use within this
plugin, like the `Fb.AppEvents.log_event` function (see the facebook
documentation for more details).

#### The `xfbml` type

This type represent the value you can obtain with `Fb.get_xfbml`, this
value is mainly used for the `Fb.parse` function.


In practice, you will have to combine several function in the same
time, like for example if you want to use the `parse` function:

```Ocaml
let p = let p =
    D.div [...]
Fb.parse (Fb.get_xfbml) ~dom:(To_dom.of_element ~%p) ()
```


### `Fb.[XXX]_available` functions

The `Fb.fbq_available` returns a boolean that indicates if the `.fbq`
module is available in your current dev environment. In the same logic,
all other function with a name that end with *_available* indicates if a
given function is available in the current environment, it is
recommended to use these functions before trying to cast functions from
this plugin.

### [TODO]
