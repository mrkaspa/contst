module Utils.Helper exposing (..)

import Model exposing (Page(..))
import Navigation
import Task
import UrlParser as P exposing ((</>), (<?>))


send : msg -> Cmd msg
send msg =
    Task.succeed msg
        |> Task.perform identity


getPage : Navigation.Location -> Page
getPage location =
    case parseRoute location of
        Just page ->
            page

        Nothing ->
            NotFound


routeParser : P.Parser (Page -> a) a
routeParser =
    P.oneOf
        [ P.map Index P.top
        , P.map Dashboard (P.s "main")
        , P.map Campaigns (P.s "campaigns")
        , P.map CampaignDetail (P.s "campaigns" </> P.int)
        ]


parseRoute : Navigation.Location -> Maybe Page
parseRoute ({ hash } as location) =
    if String.startsWith "#access_token" hash then
        Just Index
    else
        P.parseHash routeParser location


isNothing : Maybe a -> Bool
isNothing maybe =
    case maybe of
        Nothing ->
            True

        _ ->
            False
