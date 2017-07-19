module Book.List exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, src)
import Msgs exposing (Msg)
import Models exposing (Book)
import Random exposing (int, generate, Generator)

import RemoteData exposing (WebData)

view : List Book -> Html Msg
view books =
    div [ class "container" ]
    [
        multilineGrid (books |> List.map (viewHorizontalBook >> wrapInColumn))
    ]


maybeBook : WebData (List Book) -> Html Msg
maybeBook response =
    case response of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading..."

        RemoteData.Success books ->
            multilineGrid (books |> List.map (viewHorizontalBook >> wrapInColumn))

        RemoteData.Failure error ->
            text (toString error)


viewHorizontalBook : Book -> Html Msg
viewHorizontalBook book =
    div [ class "card" ]
    [
        div [ class "card-image" ]
        [
            figure [ class "image is-4by3" ]
            [
                img [ src "http://bulma.io/images/placeholders/1280x960.png" ] []
            ]
        ],

        div [ class "card-content" ]
        [
            div [ class "media" ]
            [
                div [ class "media-content" ]
                [
                    p [ class "title is-4" ] [ text book.title ],
                    p [ class "subtitle is-6" ] [ text ("por " ++ book.author) ]
                ]
            ],

            div [ class "content" ]
            [
                text book.sinopsis,
                br [] [],
                small [] [ getPageCountString book ]
            ]
        ],

        footer [ class "card-footer" ]
        [
            a [ class "card-footer-item" ] [ text "Ler" ],
            a [ class "card-footer-item" ] [ text "Compartilhar..." ]
        ]
    ]
    

getPageCountString : Book -> Html Msg
getPageCountString book =
    book.pageCount |> toString |> (\a -> a ++ " páginas") |> text


multilineGrid : List (Html Msg) -> Html Msg
multilineGrid html =
    div [ class "columns is-multiline" ] html


wrapInColumn : Html Msg -> Html Msg
wrapInColumn html =
    div [ class "column is-one-third is-narrow" ] [ html ]