# ocaml-cordova-facebook-connect-plugin
ocaml binding to the `facebookConnectPlugin` Javascript plugin using gen_js_api

# What does ocaml-cordova-facebook-connect-plugin do ?

This library allow you to use `facebookConnectPlugin` into your ocaml
app. Like it's name suggest, this plugin allow you to connect into an
app ussing a *Facebook* account.

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
See the [faceboock official
documentation](https://github.com/Wizcorp/phonegap-facebook-plugin/) for
more details.
[TODO]
