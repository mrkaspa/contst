module Model exposing (..)

import Auth.Profile exposing (ProfileData, ProfileRequestResponse)
import Http
import OAuth.OAuth as OAuth


---------------------------------------
-- Endpoints to interact with Google OAuth


authorizationEndpoint : String
authorizationEndpoint =
    "https://api.instagram.com/oauth/authorize"


profileEndpoint : OAuth.Token -> String
profileEndpoint token =
    case token of
        OAuth.Bearer token ->
            "https://api.instagram.com/v1/users/self?access_token=" ++ token



---------------------------------------
-- Basic Application Model


type alias Model =
    { oauth :
        { clientId : String
        , redirectUri : String
        }
    , error : Maybe String
    , profile : Maybe ProfileRequestResponse
    , token : Maybe OAuth.Token
    }



---------------------------------------
-- Messages for the app
--
-- Authorize -> Trigger an OAuth authorization call. The authentication is done implicitly


type Msg
    = Nop
    | Auth AuthMsg


type AuthMsg
    = Authorize
    | GetProfile (Result Http.Error ProfileData)
    | ProfileLoaded ProfileRequestResponse
    | ProfileRequest (Result Http.Error ProfileRequestResponse)
    | Logout
