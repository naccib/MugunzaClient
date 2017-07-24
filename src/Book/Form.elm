module Book.Form exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href, type_, placeholder, classList, disabled, style, id)
import Html.Events exposing (onInput, on)
import String exposing (toLower, split, trim, isEmpty, join)
import Msgs exposing (Msg(..), BookInputMsg(..))
import Models exposing (Book)

view : Book -> Html Msg
view book =
    let
        validTitle    = validInput book.title notEmpty
        validAuthor   = validInput book.author notEmpty
        validSinopsis = validInput book.sinopsis notEmpty
        validTags     = validInput (join "" book.tags) notEmpty
    in   
        form [] 
        [
            field <|
                [
                    formLabel "Título do Livro",
                    control [ input [ onInput getTitleMsg, class "input", validTitle, type_ "text", placeholder "Ex.: Dom Casmurro" ] [] ]
                ],

            field <|
                [
                    formLabel "Autor do Livro",
                    control [ input [ onInput getAuthorMsg, class "input", validAuthor, type_ "text", placeholder "Ex.: Machado de Assís" ] [] ]
                ],

            field <|
                [
                    formLabel "Sinópse do Livro",
                    control [ textarea [ onInput getSinopsisMsg, class "textarea", validSinopsis, placeholder "Ex.: Bento Santiago, já um homem de idade, conta ao leitor como recebeu a alcunha de Dom Casmurro. A expressão..." ] [] ]
                ],

            field <|
                [
                    formLabel "Tags do Livro",
                    control [ input [ onInput getTagsMsg, class "input", validTags, type_ "text", placeholder "Ex.: ação, supense, mistério" ] [] ]
                ],

            fieldWithAddons <|
                [
                    control [ staticButton "file-pdf-o" ],
                    expandedControl [ input [ class "input", type_ "file", placeholder "Clique 'Procurar' para achar um arquivo PDF...", customDisabled ] [] ],
                    control [ a [ class "button is-info" ] [ text "Procurar" ] ]
                ],

            fieldWithAddons <|
                [
                    control [ staticButton "picture-o" ],
                    expandedControl [ input [ class "input", type_ "file", placeholder "Clique 'Procurar' para achar uma capa...", id "imageInput" ] [] ],
                    control [ a [ class "button is-info" ] [ text "Procurar" ] ]
                ]
        ]


field : List (Html Msg) -> Html Msg
field html =
    div [ class "field" ] html


fieldWithAddons : List (Html Msg) -> Html Msg
fieldWithAddons html =
    div [ class "field has-addons" ] html


formLabel : String -> Html Msg
formLabel name =
    label [ class "label" ] [ text name ]


control : List (Html Msg) -> Html Msg
control html =
    div [ class "control" ] html


expandedControl : List (Html Msg) -> Html Msg
expandedControl html =
    div [ class "control is-expanded" ] html


staticButton : String -> Html Msg
staticButton icon =
    a [ class "button is-static" ] [ span [ class "icon is-small" ] [ i [ class ("fa fa-" ++ icon) ] [] ] ]


customDisabled : Attribute Msg
customDisabled =
    style [("pointer-events", "none")]

validate : String -> (String -> Bool) -> Bool
validate data function =
    function data


notEmpty : String -> Bool
notEmpty data = 
    validate data (String.isEmpty >> not)


validInput : String -> (String -> Bool) -> Attribute Msg
validInput data func =
    classList
        [ ("is-success", func data)
        , ("is-danger", not <| func data)
        ]
        

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