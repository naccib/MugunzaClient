module TaskBar.Search exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import String exposing (words, indexes, toLower)
import Msgs exposing (Msg)
import Models exposing (Book, TaskBarOptions)

type alias Match = 
    { book   : Book
    , points : Int
    }


search : TaskBarOptions -> List Book -> TaskBarOptions
search options books =
    if options.searchQuery == "" then
        { options | filteredBooks = books }
    else
        { options | filteredBooks = computeMatches options.searchQuery books }


computeMatches : String -> List Book -> List Book
computeMatches word books =
   books |> List.map (compareWordAndBook <| toLower word) |> List.sortBy .points |> List.filter (\match -> match.points /= 0) |> List.map .book |> List.reverse


compareWordAndBook : String -> Book -> Match
compareWordAndBook word book =
    let
        titlePoints    = (\len -> len * 3) <| List.length <| indexes word (toLower book.title)
        authorPoints   = (\len -> len * 2) <| List.length <| indexes word (toLower book.author)
        sinopsisPoints = (\len -> len * 1) <| List.length <| indexes word (toLower book.sinopsis)

        totalPoints = titlePoints + authorPoints + sinopsisPoints
    in
        Match book totalPoints