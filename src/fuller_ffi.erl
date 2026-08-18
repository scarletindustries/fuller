-module(fuller_ffi).
-export([boot/1]).

boot(St) ->
    Frame = {undefined, undefined, undefined, undefined},
    try fuller_react_dom_server:js_main(St, Frame, []) of
        {Exports, St1} -> {booted, Exports, St1}
    catch
        error:{wasm_exn, 0, [St1, Thrown]} -> {threw, Thrown, St1}
    end.
