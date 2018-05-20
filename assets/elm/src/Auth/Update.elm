module Auth.Update exposing (update)

import Auth.Profile exposing (ProfileData, encodeProfileRequestData, encodeProfileRequestResponse, profileData, profileRequestResponse)
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

        GetProfile res ->
            case res of
                Ok profile ->
                    model
                        ! [ createOrUpdateProfile profile token ]

                Err err ->
                    { model | error = Just "unable to fetch user profile" } ! []

        -- from local storage
        ProfileLoaded profile ->
            { model | profile = Just profile } ! []

        -- from http
        ProfileRequest res ->
            case res of
                Ok profile ->
                    { model | profile = Just profile } ! [ storageSetItem ( "profile", encodeProfileRequestResponse profile ) ]

                Err err ->
                    { model | error = Just "unable create profile" }
                        ! [ send (Auth Logout) ]

        Logout ->
            { model | profile = Nothing, token = Nothing }
                ! [ storageClear ()
                  , Navigation.modifyUrl ""
                  ]


createOrUpdateProfile : ProfileData -> Maybe OAuth.Token -> Cmd Msg
createOrUpdateProfile profileData token =
    case token of
        Just (OAuth.Bearer token) ->
            let
                profile =
                    profileData.profile

                body =
                    { instagramId = profile.id
                    , username = profile.username
                    , fullName = profile.fullName
                    , profilePicture = profile.profilePicture
                    , bio = profile.bio
                    , website = profile.website
                    , token = token
                    , isBusiness = profile.isBusiness
                    }
                        |> encodeProfileRequestData
                        |> Http.jsonBody
            in
            Http.send (Auth << ProfileRequest) <|
                Http.post
                    "/api/users"
                    body
                    profileRequestResponse

        Nothing ->
            Cmd.none
