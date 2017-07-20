{-
O goal de hoje foi implementar a search bar. Feito!

O goal de amanhã, quarta feira, é implementar Routing (https://www.elm-tutorial.org/en/07-routing/01-intro.html)
O goal para quinta feira é implementar uma página (e função) para adicionar livros.
O goal para sexta feira é implementar um método de salvar livros no servidor.

O goal de sábado é implementar uma maneira de carregar e salvar livros com .pdfs e imagens no servidor.

Eu sei que vou precisar disso depois:
    Dá pra embedar PDFs de outros domínios no Chrome! É só ler aqui, Gui: https://stackoverflow.com/a/7044015
-}

module Main exposing (..)

import Html exposing (program)
import Msgs exposing (Msg)
import Models exposing (Model, initialModel, Route(..))
import Update exposing (update)
import View exposing (view)
import Commands exposing (fetchBooks)
import Navigation exposing (Location)
import Routing

init : Location -> ( Model, Cmd Msg )
init location =
    ( initialModel (Routing.parseLocation location) , fetchBooks )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- MAIN


main : Program Never Model Msg
main =
    Navigation.program Msgs.OnLocationChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }