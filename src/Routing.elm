module Routing exposing (..)

import Navigation exposing (Location)
import Models exposing (Route(..))
import UrlParser exposing (..)

matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map BookListRoute top
        , map AddBookRoute (s "add-book")
        , map BookListRoute (s "books")
        ]


parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route

        Nothing ->
            NotFoundRoute


bookListPath : String
bookListPath = 
    "#books"

addBookPath : String
addBookPath = 
    "#add-book"