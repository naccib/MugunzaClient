module Update exposing (..)

import Msgs exposing (Msg(..), BookInputMsg(..))
import Models exposing (Model, TaskBarOptions, Book)
import Commands exposing (saveBookCmd, fetchBooks)
import TaskBar.Search exposing (search)
import RemoteData exposing (WebData)
import Routing exposing (parseLocation)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        OnBooksFetched response ->
            { model | books = response, visibleBooks = unwrapBookWebData response } ! []

        UpdateQuery newQuery ->
            { model | taskbar =  updateTaskbarQuery model.taskbar newQuery }
                |> update UpdateSearchBooks

        UpdateSearchBooks ->
            { model | visibleBooks =  model.books |> unwrapBookWebData |> search model.taskbar |> .filteredBooks } ! []

        OnLocationChange location ->
            let
                newRoute =
                    parseLocation location
            in
                ( { model | route = newRoute }, Cmd.none )

        OnBookUpdate msg ->
            updateBook model msg

        SaveBook book ->
            (model, saveBookCmd book)

        OnBookSave (Ok book) ->
            (model, Cmd.none)

        OnBookSave (Err error) ->
            (model, Cmd.none)


updateTaskbarQuery : TaskBarOptions -> String -> TaskBarOptions
updateTaskbarQuery taskbar newQuery =
    { taskbar | searchQuery = newQuery }


unwrapBookWebData : WebData (List Book) -> List Book
unwrapBookWebData data =
    case data of

        RemoteData.Success books ->
            books

        _ ->
            []

updateBook : Model -> BookInputMsg -> (Model, Cmd Msg)
updateBook model msg =
    case msg of
        OnTitleUpdate newTitle ->
            { model | inputBook = changeBookTitle model.inputBook newTitle } ! []

        OnAuthorUpdate newAuthor ->
            { model | inputBook = changeBookAuthor model.inputBook newAuthor } ! []

        OnSinopsisUpdate newSinopsis ->
            { model | inputBook = changeBookSinopsis model.inputBook newSinopsis } ! []

        OnTagsUpdate newTags ->
            { model | inputBook = changeBookTags model.inputBook newTags } ! []


changeBookTitle : Book -> String -> Book
changeBookTitle book newTitle =
    { book | title = newTitle }


changeBookAuthor : Book -> String -> Book
changeBookAuthor book newAuthor =
    { book | author = newAuthor }


changeBookSinopsis : Book -> String -> Book
changeBookSinopsis book newSinopsis =
    { book | sinopsis = newSinopsis }


changeBookTags : Book -> List String -> Book
changeBookTags book newTags =
    { book | tags = newTags }