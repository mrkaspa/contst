module Update exposing (update)

import Auth.Update
import Model exposing (Model, Msg(..))


-- Update is pretty straightforward.


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Nop ->
            model ! []

        Auth authMsg ->
            Auth.Update.update authMsg model
