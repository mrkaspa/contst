module View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (Model, Msg(..))


---------------------------------------
-- The View. Sorry for this. Nothing interesting here.


view : Model -> Html Msg
view model =
    let
        isNothing maybe =
            case maybe of
                Nothing ->
                    True

                _ ->
                    False

        content =
            case ( model.token, model.profile ) of
                ( Nothing, Nothing ) ->
                    Html.form
                        [ onSubmit Authorize
                        , style
                            [ ( "flex-direction", "column" )
                            ]
                        ]
                        [ button
                            [ style
                                [ ( "background", "url('/elm-oauth2/examples/images/google.png') 1em center no-repeat" )
                                , ( "background-size", "2em" )
                                , ( "border", "none" )
                                , ( "box-shadow", "rgba(0,0,0,0.25) 0px 2px 4px 0px" )
                                , ( "color", "#757575" )
                                , ( "font", "Roboto, Arial" )
                                , ( "margin", "1em" )
                                , ( "outline", "none" )
                                , ( "padding", "1em 1em 1em 3em" )
                                , ( "text-align", "right" )
                                ]
                            , onClick Authorize
                            ]
                            [ text "Sign in" ]
                        ]

                ( Just token, Nothing ) ->
                    div
                        [ style
                            [ ( "color", "#757575" )
                            , ( "font", "Roboto, Arial" )
                            , ( "text-align", "center" )
                            ]
                        ]
                        [ text "fetching profile..." ]

                ( _, Just profileData ) ->
                    div
                        [ style
                            [ ( "display", "flex" )
                            , ( "flex-direction", "column" )
                            , ( "align-items", "center" )
                            ]
                        ]
                        [ img
                            [ src profileData.profile.profilePicture
                            , style
                                [ ( "height", "150px" )
                                , ( "margin", "1em" )
                                , ( "width", "150px" )
                                ]
                            ]
                            []
                        , text <| profileData.profile.fullName ++ " <" ++ profileData.profile.username ++ ">"
                        ]
    in
    div
        [ style
            [ ( "display", "flex" )
            , ( "flex-direction", "column" )
            , ( "align-items", "center" )
            , ( "padding", "3em" )
            ]
        ]
        [ h2
            [ style
                [ ( "display", "flex" )
                , ( "font-family", "Roboto, Arial, sans-serif" )
                , ( "color", "#141414" )
                ]
            ]
            [ text "OAuth 2.0 Implicit Flow Example" ]
        , div
            [ style
                [ ( "display"
                  , if isNothing model.error then
                        "none"
                    else
                        "block"
                  )
                , ( "width", "100%" )
                , ( "position", "absolute" )
                , ( "top", "0" )
                , ( "padding", "1em" )
                , ( "font-family", "Roboto, Arial, sans-serif" )
                , ( "text-align", "center" )
                , ( "background", "#e74c3c" )
                , ( "color", "#ffffff" )
                ]
            ]
            [ text <| Maybe.withDefault "" model.error ]
        , content
        ]
