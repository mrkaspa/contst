module OAuth.ClientCredentials
    exposing
        ( authenticate
        , authenticateWithOpts
        )

{-| The client can request an access token using only its client
credentials (or other supported means of authentication) when the client is requesting access to
the protected resources under its control, or those of another resource owner that have been
previously arranged with the authorization server (the method of which is beyond the scope of
this specification).

There's only one step in this process:

  - The client authenticates itself directly using credentials it owns.

After this step, the client owns an `access_token` that can be used to authorize any subsequent
request.


## Authenticate

@docs authenticate, authenticateWithOpts

-}

import OAuth exposing (..)
import OAuth.Decode exposing (..)
import OAuth.Internal as OAuth.Internal
import Http as Http


{-| Authenticate the client using the authorization code obtained from the authorization.

In this case, use the `ClientCredentials` constructor.

-}
authenticate : Authentication -> Http.Request ResponseToken
authenticate =
    OAuth.Internal.authenticate identity


{-| Authenticate the client using the authorization code obtained from the authorization, passing
additional custom options. Use with care.

In this case, use the `ClientCredentials` constructor.

-}
authenticateWithOpts : AdjustRequest ResponseToken -> Authentication -> Http.Request ResponseToken
authenticateWithOpts fn =
    OAuth.Internal.authenticate fn
