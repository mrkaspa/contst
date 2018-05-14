module Init exposing (init)

import Http
import Json.Profile exposing (profileData)
import Model exposing (Model, Msg(..), profileEndpoint)
import Navigation
import OAuth
import OAuth.Implicit
import Ports.LocalStorage exposing (..)


init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    let
        model =
            { oauth =
                { clientId = "51d99f475ebf45239680bde75d5eb9fd"
                , redirectUri = location.origin ++ location.pathname
                }
            , error = Nothing
            , token = Nothing
            , profile = Nothing
            }
    in
    case OAuth.Implicit.parse location of
        Ok { token } ->
            let
                req =
                    Http.request
                        { method = "GET"
                        , body = Http.emptyBody
                        , withCredentials = False
                        , headers = []
                        , url = profileEndpoint token
                        , expect = Http.expectJson profileData
                        , timeout = Nothing
                        }
            in
            { model | token = Just token }
                ! [ Navigation.modifyUrl model.oauth.redirectUri
                  , Http.send GetProfile req
                  ]

        Err OAuth.Empty ->
            model ! [ storageGetItem "profile" ]

        Err (OAuth.OAuthErr err) ->
            { model | error = Just <| OAuth.showErrCode err.error }
                ! [ Navigation.modifyUrl model.oauth.redirectUri ]

        Err _ ->
            { model | error = Just "parsing error" } ! []
