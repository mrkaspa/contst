module Auth.Profile
    exposing
        ( Counts
        , Profile
        , ProfileData
        , ProfileRequestData
        , ProfileRequestResponse
        , encodeProfileData
        , encodeProfileRequestData
        , encodeProfileRequestResponse
        , profileData
        , profileRequestData
        , profileRequestResponse
        )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Json.Encode.Extra as JencExtra


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


type alias ProfileRequestData =
    { instagramId : String
    , username : String
    , fullName : String
    , profilePicture : String
    , bio : String
    , website : String
    , token : String
    , isBusiness : Bool
    }


profileRequestData : Jdec.Decoder ProfileRequestData
profileRequestData =
    Jpipe.decode ProfileRequestData
        |> Jpipe.required "instagram_id" Jdec.string
        |> Jpipe.required "username" Jdec.string
        |> Jpipe.required "name" Jdec.string
        |> Jpipe.required "profile_picture" Jdec.string
        |> Jpipe.required "bio" Jdec.string
        |> Jpipe.required "website" Jdec.string
        |> Jpipe.required "token" Jdec.string
        |> Jpipe.required "is_business" Jdec.bool


encodeProfileRequestData : ProfileRequestData -> Jenc.Value
encodeProfileRequestData x =
    Jenc.object
        [ ( "instagram_id", Jenc.string x.instagramId )
        , ( "username", Jenc.string x.username )
        , ( "name", Jenc.string x.fullName )
        , ( "profile_picture", Jenc.string x.profilePicture )
        , ( "bio", Jenc.string x.bio )
        , ( "website", Jenc.string x.website )
        , ( "token", Jenc.string x.token )
        , ( "is_business", Jenc.bool x.isBusiness )
        ]


type alias ProfileRequestResponse =
    { id : Int
    , instagramId : String
    , username : String
    , fullName : String
    , profilePicture : Maybe String
    , bio : Maybe String
    , website : Maybe String
    , token : Maybe String
    , isBusiness : Maybe Bool
    , insertedAt : String
    , updatedAt : String
    }


profileRequestResponse : Jdec.Decoder ProfileRequestResponse
profileRequestResponse =
    Jpipe.decode ProfileRequestResponse
        |> Jpipe.required "id" Jdec.int
        |> Jpipe.required "instagram_id" Jdec.string
        |> Jpipe.required "username" Jdec.string
        |> Jpipe.required "name" Jdec.string
        |> Jpipe.required "profile_picture" (Jdec.maybe Jdec.string)
        |> Jpipe.required "bio" (Jdec.maybe Jdec.string)
        |> Jpipe.required "website" (Jdec.maybe Jdec.string)
        |> Jpipe.required "token" (Jdec.maybe Jdec.string)
        |> Jpipe.required "is_business" (Jdec.maybe Jdec.bool)
        |> Jpipe.required "inserted_at" Jdec.string
        |> Jpipe.required "updated_at" Jdec.string


encodeProfileRequestResponse : ProfileRequestResponse -> Jenc.Value
encodeProfileRequestResponse x =
    Jenc.object
        [ ( "id", Jenc.int x.id )
        , ( "instagram_id", Jenc.string x.instagramId )
        , ( "username", Jenc.string x.username )
        , ( "name", Jenc.string x.fullName )
        , ( "profile_picture", JencExtra.maybe Jenc.string x.profilePicture )
        , ( "bio", JencExtra.maybe Jenc.string x.bio )
        , ( "website", JencExtra.maybe Jenc.string x.website )
        , ( "token", JencExtra.maybe Jenc.string x.token )
        , ( "is_business", JencExtra.maybe Jenc.bool x.isBusiness )
        , ( "updated_at", Jenc.string x.updatedAt )
        , ( "inserted_at", Jenc.string x.insertedAt )
        ]
