port module Ports.LocalStorage exposing (..)

import Auth.Profile exposing (profileRequestResponse)
import Json.Decode as JDec
import Json.Encode
import Model exposing (AuthMsg(..), Msg(..))


type alias Key =
    String


type alias Value =
    Json.Encode.Value


receiveLocalStorage : ( Key, Value ) -> Msg
receiveLocalStorage keyVal =
    case keyVal of
        ( "profile", profile ) ->
            case JDec.decodeValue profileRequestResponse profile of
                Ok profile ->
                    Auth (ProfileLoaded profile)

                Err _ ->
                    Nop

        _ ->
            Nop


{-| Subscriptions (Receive from JS)
-}
port storageGetItemResponse : (( Key, Value ) -> msg) -> Sub msg


{-| Commands (Send to JS)
-}



-- Mapped to Storage API: https://developer.mozilla.org/en-US/docs/Web/API/Storage


port storageGetItem : Key -> Cmd msg


port storageSetItem : ( Key, Value ) -> Cmd msg


port storageRemoveItem : Key -> Cmd msg


port storageClear : () -> Cmd msg



-- Not in Storage API


port storagePushToSet : ( Key, Value ) -> Cmd msg


port storageRemoveFromSet : ( Key, Value ) -> Cmd msg
