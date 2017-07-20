module TaskBar.TaskBar exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Msgs exposing (Msg(..))
import Models exposing (Book, TaskBarOptions)
import Routing exposing (addBookPath)

import TaskBar.Search exposing (search)

taskbar : TaskBarOptions -> Html Msg
taskbar options =
    nav [ class "nav has-shadow" ]
    [
        div [ class "nav-left" ]
        [
            a [ class "nav-item" ]
            [
                img [ src "../../assets/logo-normal.png", alt "Módulo Solidário" ] []
            ],
            a [ class "nav-item", href addBookPath ]
            [
                text "Adicionar Livro"
            ]
        ],

        div [ class "nav-center" ]
        [
            div [ class "nav-item", style [("padding-top", "1.5em")] ]
            [
                div [ class "field has-addons" ]
                [
                    p [ class "control" ] [ input [ onInput UpdateQuery, class "input", type_ "text", placeholder "Procure um livro..." ] [] ],
                    p [ class "control" ] [ button [ onClick UpdateSearchBooks, class "button" ] [ text "Procurar" ] ]
                ]
            ]
        ],

        div [ class "nav-right" ]
        [
            div [ class "nav-item" ]
            [
                p [ class "control" ]
                [
                    a [ class "button is-active" ]
                    [
                        span [ class "icon" ]
                        [
                            i [ class "fa fa-align-justify" ] []
                        ],

                        span [] [ text "Horizontal" ]
                    ]
                ]
            ],
            div [ class "nav-item" ]
            [
                p [ class "control" ]
                [
                    a [ class "button" ]
                    [
                        span [ class "icon" ]
                        [
                            i [ class "fa fa-align-justify fa-rotate-90" ] []
                        ],

                        span [] [ text "Vertical" ]
                    ]
                ]
            ]
        ]
    ]
