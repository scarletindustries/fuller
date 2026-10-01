-module(fuller_ffi).
-export([boot/1, coerce/1, pdict_put/2, pdict_get/1, pdict_erase/1]).

boot(St) ->
    Frame = {undefined, undefined, undefined, undefined},
    try fuller_react_dom_server:js_main(St, Frame, []) of
        {Exports, St1} -> {booted, Exports, St1}
    catch
        error:{wasm_exn, 0, [St1, Thrown]} -> {threw, Thrown, St1}
    end.

coerce(X) -> X.

pdict_put(Key, Value) ->
    put({fuller, Key}, Value),
    nil.

pdict_get(Key) ->
    case get({fuller, Key}) of
        undefined -> none;
        Value -> {some, Value}
    end.

pdict_erase(Key) ->
    erase({fuller, Key}),
    nil.
