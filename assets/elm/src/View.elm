module View exposing (view)

import Auth.View as AuthView
import Html exposing (..)
import Model exposing (Model, Msg(..), Page(..))


---------------------------------------
-- The View. Sorry for this. Nothing interesting here.


view : Model -> Html Msg
view ({ page } as model) =
    case page of
        Index ->
            AuthView.view model

        Dashboard ->
            div []
                [ h1 [] [ text "demo" ]
                ]
