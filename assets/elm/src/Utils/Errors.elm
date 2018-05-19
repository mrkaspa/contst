module Utils.Errors exposing (..)

import Dict exposing (Dict)
import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe


type alias ValidationErrors =
    { errors : Dict String (List String)
    }


validationErrorsDecoder : Jdec.Decoder ValidationErrors
validationErrorsDecoder =
    Jpipe.decode ValidationErrors
        |> Jpipe.required "errors" errorMapDecoder


errorMapDecoder : Jdec.Decoder (Dict String (List String))
errorMapDecoder =
    Jdec.dict (Jdec.list Jdec.string)
