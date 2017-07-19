module Book.Add exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href)
import Msgs exposing (Msg(..))
import Models exposing (Book)

import Routing exposing (bookListPath)
import Book.Form

view : Book -> Html Msg
view book =
    div [ class "modal is-active" ]
    [
        div [ class "modal-background" ] [],
        div [ class "modal-card" ]
        [
            modalHead book,
            modalContent book,
            modalFooter book
        ]
    ]


modalHead : Book -> Html Msg
modalHead book =
    header [ class "modal-card-head" ]
    [
        p [ class "modal-card-title" ]
        [
            text "Adicionar Livro"
        ],
        a [ class "delete", closeButton ] []
    ]


modalContent : Book -> Html Msg
modalContent book =
    section [ class "modal-card-body" ] [ Book.Form.view ]


modalFooter : Book -> Html Msg
modalFooter book =
    footer [ class "modal-card-foot" ]
    [
        a [ class "button is-success" ] [ text "Criar Livro" ],
        a [ class "button", closeButton ] [ text "Cancelar" ]
    ]

closeButton : Attribute Msg
closeButton =
    href bookListPath