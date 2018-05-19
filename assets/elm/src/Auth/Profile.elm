module Auth.Profile
    exposing
        ( Counts
        , Profile
        , ProfileData
        , ProfileRequestData
        , encodeProfileData
        , encodeProfileRequestData
        , profileData
        , profileRequestData
        )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc


type alias ProfileData =
    { profile : Profile
    }


type alias Profile =
    { id : String
    , username : String
    , fullName : String
    , profilePicture : String
    , bio : String
    , website : String
    , isBusiness : Bool
    , counts : Counts
    }


type alias Counts =
    { media : Int
    , follows : Int
    , followedBy : Int
    }


type alias ProfileRequestData =
    { username : String
    , token : String
    }



-- decoders and encoders


profileData : Jdec.Decoder ProfileData
profileData =
    Jpipe.decode ProfileData
        |> Jpipe.required "data" profile


encodeProfileData : ProfileData -> Jenc.Value
encodeProfileData x =
    Jenc.object
        [ ( "data", encodeProfile x.profile )
        ]


profile : Jdec.Decoder Profile
profile =
    Jpipe.decode Profile
        |> Jpipe.required "id" Jdec.string
        |> Jpipe.required "username" Jdec.string
        |> Jpipe.required "full_name" Jdec.string
        |> Jpipe.required "profile_picture" Jdec.string
        |> Jpipe.required "bio" Jdec.string
        |> Jpipe.required "website" Jdec.string
        |> Jpipe.required "is_business" Jdec.bool
        |> Jpipe.required "counts" counts


profileRequestData : Jdec.Decoder ProfileRequestData
profileRequestData =
    Jpipe.decode ProfileRequestData
        |> Jpipe.required "id" Jdec.string
        |> Jpipe.required "username" Jdec.string


encodeProfile : Profile -> Jenc.Value
encodeProfile x =
    Jenc.object
        [ ( "id", Jenc.string x.id )
        , ( "username", Jenc.string x.username )
        , ( "full_name", Jenc.string x.fullName )
        , ( "profile_picture", Jenc.string x.profilePicture )
        , ( "bio", Jenc.string x.bio )
        , ( "website", Jenc.string x.website )
        , ( "is_business", Jenc.bool x.isBusiness )
        , ( "counts", encodeCounts x.counts )

        -- , ( "token"
        --   , Jenc.string <|
        --         case x.token of
        --             Just (OAuth.Bearer token) ->
        --                 token
        --             Nothing ->
        --                 ""
        --   )
        ]


counts : Jdec.Decoder Counts
counts =
    Jpipe.decode Counts
        |> Jpipe.required "media" Jdec.int
        |> Jpipe.required "follows" Jdec.int
        |> Jpipe.required "followed_by" Jdec.int



-- tokenDec : Jdec.Decoder (Maybe OAuth.Token)
-- tokenDec =
--     Jdec.map (\s -> Just (OAuth.Bearer s)) Jdec.string


encodeCounts : Counts -> Jenc.Value
encodeCounts x =
    Jenc.object
        [ ( "media", Jenc.int x.media )
        , ( "follows", Jenc.int x.follows )
        , ( "followed_by", Jenc.int x.followedBy )
        ]


encodeProfileRequestData : ProfileRequestData -> Jenc.Value
encodeProfileRequestData x =
    Jenc.object
        [ ( "username", Jenc.string x.username )
        , ( "token", Jenc.string x.token )
        ]
