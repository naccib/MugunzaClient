module Models exposing (..)

import RemoteData exposing (WebData)

initialModel : Route -> Model
initialModel route = 
    { books = RemoteData.Loading
    , visibleBooks = []
    , taskbar = TaskBarOptions "" [] Normal
    , route = route
    , inputBook = Book "" "" "" [] 0 ""
    }

type alias Model =
    { books : WebData (List Book)
    , visibleBooks : List Book
    , taskbar : TaskBarOptions
    , route : Route
    , inputBook : Book
    }

type alias Book =
    { title     : String
    , author    : String
    , sinopsis  : String
    , tags      : List String
    , pageCount : Int
    , id : BookId
    }

type alias BookId =
    String

type ListOrientation =
    Normal
    | Tiles

type Route =
    BookListRoute
    | AddBookRoute
    | NotFoundRoute

type alias TaskBarOptions =
    { searchQuery : String
    , filteredBooks : List Book
    , listOrientation : ListOrientation
    }