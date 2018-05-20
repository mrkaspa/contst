module Init exposing (init)

import Auth.Profile exposing (profileData)
import Http
import Model exposing (AuthMsg(..), Model, Msg(..), Page(..), profileEndpoint)
import Navigation
import OAuth.Implicit
import OAuth.OAuth as OAuth
import Ports.LocalStorage exposing (..)
import Utils.Helper exposing (getPage)


init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    let
        model =
            initState location
    in
    case getPage location of
        Index ->
            oauthFlow { model | page = Index } location

        page ->
            { model | page = page } ! []


oauthFlow : Model -> Navigation.Location -> ( Model, Cmd Msg )
oauthFlow model location =
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
                  , Http.send (Auth << GetProfile) req
                  ]

        Err OAuth.Empty ->
            model ! [ storageGetItem "profile" ]

        Err (OAuth.OAuthErr err) ->
            { model | error = Just <| OAuth.showErrCode err.error }
                ! [ Navigation.modifyUrl model.oauth.redirectUri ]

        Err _ ->
            { model | error = Just "parsing error" } ! []


initState : Navigation.Location -> Model
initState location =
    { oauth =
        { clientId = "51d99f475ebf45239680bde75d5eb9fd"
        , redirectUri = location.origin ++ location.pathname
        }
    , page = Index
    , error = Nothing
    , token = Nothing
    , profile = Nothing
    }
