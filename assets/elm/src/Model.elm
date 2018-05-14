module Model exposing (..)

import Http
import Json.Profile exposing (ProfileData)
import OAuth


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
    , token : Maybe OAuth.Token
    , profile : Maybe ProfileData
    }



---------------------------------------
-- Messages for the app
--
-- Authorize -> Trigger an OAuth authorization call. The authentication is done implicitly


type Msg
    = Nop
    | Authorize
    | GetProfile (Result Http.Error ProfileData)
    | NewProfile ProfileData
