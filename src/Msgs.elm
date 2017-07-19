module Msgs exposing (..)

import RemoteData exposing (WebData)
import Navigation exposing (Location)
import Models exposing (Book)

type Msg
    = NoOp
    | OnBooksFetched (WebData (List Book))
    | OnLocationChange Location
    | UpdateQuery String
    | UpdateSearchBooks
    | OnBookUpdate BookInputMsg


type BookInputMsg
    = OnTitleUpdate String
    | OnAuthorUpdate String
    | OnSinopsisUpdate String
    | OnTagsUpdate (List String)
