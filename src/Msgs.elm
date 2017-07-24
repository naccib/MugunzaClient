module Msgs exposing (..)

import RemoteData exposing (WebData)
import Navigation exposing (Location)
import Http
import Models exposing (Book)

type Msg
    = NoOp
    | OnBooksFetched (WebData (List Book))
    | OnLocationChange Location
    | UpdateQuery String
    | UpdateSearchBooks
    | SaveBook Book
    | OnBookUpdate BookInputMsg
    | OnBookClear
    | OnBookSave (Result Http.Error Book)


type BookInputMsg
    = OnTitleUpdate String
    | OnAuthorUpdate String
    | OnSinopsisUpdate String
    | OnTagsUpdate (List String)
