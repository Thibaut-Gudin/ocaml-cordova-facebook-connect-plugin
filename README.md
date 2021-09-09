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

### The `ConnectPlugin` module

This module do the binding to the `facebookConnectPlugin` plugin.

See the [faceboock official
documentation](https://github.com/Wizcorp/phonegap-facebook-plugin/) for
more details.
[TODO]
