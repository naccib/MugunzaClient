module View exposing (..)

import Html exposing (Html, div, text, body)
import Html.Attributes exposing (class)
import Msgs exposing (Msg)
import Models exposing (Model)
import TaskBar.TaskBar exposing (taskbar)

import Book.List
import Book.Add
import Navbar


view : Model -> Html Msg
view model =
    body []
    [
        Navbar.navbar,
        taskbar model.taskbar,
        div [] [ page model ]
    ]


page : Model -> Html Msg
page model =
    case model.route of
        Models.BookListRoute ->
            Book.List.view model.books model.visibleBooks

        Models.AddBookRoute ->
            Book.Add.view model.inputBook

        Models.NotFoundRoute ->
            notFoundView


notFoundView : Html Msg
notFoundView = 
    div [] [ text "Not found" ]