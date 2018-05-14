module Update exposing (update)

import Json.Profile exposing (encodeProfileData)
import Model exposing (Model, Msg(..), authorizationEndpoint)
import OAuth
import OAuth.Implicit
import Ports.LocalStorage exposing (storageSetItem)


-- Update is pretty straightforward.


update : Msg -> Model -> ( Model, Cmd Msg )
update msg ({ oauth } as model) =
    case msg of
        Nop ->
            model ! []

        GetProfile res ->
            case res of
                Err err ->
                    { model | error = Just "unable to fetch user profile ¯\\_(ツ)_/¯" } ! []

                Ok profile ->
                    { model | profile = Just profile } ! [ storageSetItem ( "profile", encodeProfileData profile ) ]

        NewProfile profile ->
            { model | profile = Just profile } ! []

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
