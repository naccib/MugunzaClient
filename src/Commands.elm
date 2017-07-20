module Commands exposing (..)

import Http exposing (header)
import Json.Decode as Decode
import Json.Encode as Encode
import Json.Decode.Pipeline exposing (decode, required)
import Msgs exposing (Msg)
import Models exposing (Book)
import RemoteData

dataUrl : String
dataUrl =
    "http://localhost:4000/books"

saveBookUrl : String
saveBookUrl =
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
        |> required "id" Decode.string


saveBookRequest : Book -> Http.Request Book
saveBookRequest book =
    Http.request
        { body = bookEncoder book |> Http.jsonBody
        , expect = Http.expectJson bookDecoder
        , headers = []
        , method = "POST"
        , timeout = Nothing
        , url = saveBookUrl
        , withCredentials = False
        }

saveBookCmd : Book -> Cmd Msg
saveBookCmd book =
    saveBookRequest book
        |> Http.send Msgs.OnBookSave

bookEncoder : Book -> Encode.Value
bookEncoder book =
    let
        attributes =
            [ ( "title", Encode.string book.title )
            , ( "author", Encode.string book.author )
            , ( "sinopsis", Encode.string book.sinopsis )
            , ( "tags", Encode.list (List.map Encode.string book.tags) )
            , ( "pageCount", ( Encode.int book.pageCount ) )
            , ( "id", Encode.string book.id )
            ]
    in
        Encode.object attributes