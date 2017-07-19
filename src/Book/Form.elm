module Book.Form exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href, type_, placeholder)
import Html.Events exposing (onInput)
import String exposing (toLower, split, trim)
import Msgs exposing (Msg(..), BookInputMsg(..))
import Models exposing (Book)

view : Html Msg
view =
    form [] 
    [
        field <|
            [
                formLabel "Título do Livro",
                control [ input [ onInput getTitleMsg, class "input", type_ "text", placeholder "Ex.: Dom Casmurro" ] [] ]
            ],

        field <|
            [
                formLabel "Autor do Livro",
                control [ input [ onInput getAuthorMsg, class "input", type_ "text", placeholder "Ex.: Machado de Assís" ] [] ]
            ],

        field <|
            [
                formLabel "Sinópse do Livro",
                control [ textarea [ onInput getSinopsisMsg, class "textarea", placeholder "Bento Santiago, já um homem de idade, conta ao leitor como recebeu a alcunha de Dom Casmurro. A expressão..." ] [] ]
            ],

        field <|
            [
                formLabel "Tags do Livro",
                control [ input [ onInput getTagsMsg , class "input", type_ "text", placeholder "Ex.: ação, supense, mistério" ] [] ]
            ]
    ]


field : List (Html Msg) -> Html Msg
field html =
    div [ class "field" ] html


formLabel : String -> Html Msg
formLabel name =
    label [ class "label" ] [ text name ]


control : List (Html Msg) -> Html Msg
control html =
    div [ class "control" ] html


getTags : String -> List String
getTags str =
    str |> toLower |> trim |> split ","


getTitleMsg : String -> Msg
getTitleMsg title =
    OnBookUpdate (OnTitleUpdate title)


getAuthorMsg : String -> Msg
getAuthorMsg author =
    OnBookUpdate (OnAuthorUpdate author)


getSinopsisMsg : String -> Msg
getSinopsisMsg sinopsis =
    OnBookUpdate (OnSinopsisUpdate sinopsis)


getTagsMsg : String -> Msg
getTagsMsg str =
    let
        tags = getTags str
        msg  = OnTagsUpdate tags
    in
        OnBookUpdate msg