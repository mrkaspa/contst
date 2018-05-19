module Auth.Update exposing (update)

import Auth.Profile exposing (ProfileData, encodeProfileData, encodeProfileRequestData, profileData, profileRequestData)
import Http
import Model exposing (AuthMsg(..), Model, Msg(..), authorizationEndpoint)
import Navigation
import OAuth.Implicit
import OAuth.OAuth as OAuth
import Ports.LocalStorage exposing (storageClear, storageSetItem)
import Utils.Helper exposing (send)


update : AuthMsg -> Model -> ( Model, Cmd Msg )
update msg ({ token } as model) =
    case msg of
        GetProfile res ->
            case res of
                Ok profile ->
                    { model | profile = Just profile }
                        ! [ storageSetItem ( "profile", encodeProfileData profile )
                          , createOrUpdateProfile profile token
                          ]

                Err err ->
                    { model | error = Just "unable to fetch user profile" } ! []

        ProfileLoaded profile ->
            { model | profile = Just profile } ! []

        Logout ->
            { model | profile = Nothing, token = Nothing }
                ! [ storageClear ()
                  , Navigation.modifyUrl ""
                  ]

        Authorize ->
            model
                ! [ OAuth.Implicit.authorize
                        { clientId = model.oauth.clientId
                        , redirectUri = model.oauth.redirectUri
                        , responseType = OAuth.Token
                        , scope = [ "basic", "public_content" ]
                        , state = Nothing
                        , url = authorizationEndpoint
                        }
                  ]

        ProfileRequest res ->
            case res of
                Ok _ ->
                    model ! []

                Err err ->
                    let
                        _ =
                            Debug.log "err req = " err
                    in
                    { model | error = Just "unable create profile" }
                        ! [ send (Auth Logout) ]


createOrUpdateProfile : ProfileData -> Maybe OAuth.Token -> Cmd Msg
createOrUpdateProfile profile token =
    case token of
        Just (OAuth.Bearer token) ->
            let
                body =
                    { username = profile.profile.username
                    , token = token
                    }
                        |> encodeProfileRequestData
                        |> Http.jsonBody
            in
            Http.send (Auth << ProfileRequest) <|
                Http.post
                    "/api/users"
                    body
                    profileRequestData

        Nothing ->
            Cmd.none
