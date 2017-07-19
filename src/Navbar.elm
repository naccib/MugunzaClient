module Navbar exposing (navbar)

import Html exposing (Html, div, text, section, h1, h2, header, a, img, span, body, li, ul, nav)
import Html.Attributes exposing (class, src, href)
import Msgs exposing (Msg)
import Models exposing (Model)
import Routing exposing (addBookPath)

navbar : Html Msg
navbar =
    section [ class "hero is-primary is-medium" ]
    [
        -- head

        div [ class "hero-head" ]
        [
            navbarHeadNav
        ],

        div [ class "hero-body" ]
        [
            div [ class "container has-text-centered" ]
            [
                h1 [ class "title" ] [ text "Modulo Solidário" ],
                h2 [ class "title" ] [ text "Leia, aprenda e compartilhe." ]
            ]
        ]
    ]

navbarHeadNav : Html Msg
navbarHeadNav = 
    header [ class "nav" ]
            [
                div [ class "container" ]
                [
                    div [ class "nav-left" ]
                    [
                        a [ class "nav-item" ]
                        [
                            img [ src "../assets/logo-normal.png" ] []
                        ]
                    ],

                    div [ class "nav-right nav-menu" ]
                    [
                        a [ class "nav-item is-active" ]
                        [
                            text "Início"
                        ],
                        a [ class "nav-item" ]
                        [
                            text "Como Usar"
                        ],
                        span [ class "nav-item" ]
                        [
                            a [ class "button is-primary is-inverted", href addBookPath ]
                            [
                                text "Adicionar Livro"
                            ]
                        ]
                    ]
                ]
            ]