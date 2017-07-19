module Commands exposing (..)

import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import Msgs exposing (Msg)
import Models exposing (Book)
import RemoteData

dataUrl : String
dataUrl =
    "http://localhost:4000/books"

fetchBooks : Cmd Msg
fetchBooks =
    Http.get dataUrl bookListDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnBooksFetched

bookListDecoder : Decode.Decoder (List Book)
bookListDecoder =
    Decode.list bookDecoder

bookDecoder : Decode.Decoder Book
bookDecoder =
    decode Book
        |> required "title" Decode.string
        |> required "author" Decode.string
        |> required "sinopsis" Decode.string
        |> required "tags" (Decode.list Decode.string)
        |> required "pageCount" Decode.int