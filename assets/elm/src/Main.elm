module Main exposing (..)

import Init exposing (init)
import Model exposing (Model, Msg(..))
import Navigation
import Ports.LocalStorage exposing (receiveLocalStorage, storageGetItemResponse)
import Update exposing (update)
import View exposing (view)


main : Program Never Model Msg
main =
    Navigation.program
        (\location -> NewUrl location)
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.batch [ storageGetItemResponse receiveLocalStorage ]
        }
