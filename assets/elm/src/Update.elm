module Update exposing (update)

import Auth.Update
import Model exposing (Model, Msg(..), Page(..))
import Utils.Helper exposing (getPage)


-- Update is pretty straightforward.


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Nop ->
            model ! []

        NewUrl location ->
            { model | page = getPage location } ! []

        Auth authMsg ->
            Auth.Update.update authMsg model
