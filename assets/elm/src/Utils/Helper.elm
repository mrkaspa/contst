module Utils.Helper exposing (..)

import Model exposing (Page(..))
import Navigation
import Task


send : msg -> Cmd msg
send msg =
    Task.succeed msg
        |> Task.perform identity


getPage : Navigation.Location -> Page
getPage { hash } =
    case hash of
        "" ->
            Index

        "#main" ->
            Dashboard

        _ ->
            Index


isNothing : Maybe a -> Bool
isNothing maybe =
    case maybe of
        Nothing ->
            True

        _ ->
            False
