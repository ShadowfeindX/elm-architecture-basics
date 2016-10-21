-- BEGIN
module Greeting exposing (..)

-- IMPORTS
import Html exposing (..)
import Html.App as Html
import Html.Events exposing (..)
import Html.Attributes exposing (..)

import Array

--MAIN
main = Html.beginnerProgram {
  model = model,
  view = view,
  update = update
  }

-- MODEL
type alias Model = { person : String, todo : List (Html Msg), new : String}

model : Model
model = {
  person = "Jason",
  todo = [ li [][ button [ onClick (Edit 0) ][ text "Edit" ], button [ onClick (Delete 0) ][ text "Delete" ], text " Sample Todo Item" ] ],
  new = ""
  }


-- UPDATE
type Msg = Input String | Add | Edit Int | Delete Int

update : Msg -> Model -> Model
update msg model =
  case msg of
    Input item -> { model | new = item }
    Add -> { model | todo = (addTodo model.new model.todo) }
    Edit index -> { model | todo = (editTodo index model.new model.todo) }
    Delete index-> { model | todo = (deleteTodo index model.new model.todo) }

addTodo : String -> List (Html Msg) -> List (Html Msg)
addTodo new todo = 
  todo ++ [ li [][ button [ onClick (Edit (List.length todo)) ][ text "Edit" ], button [ onClick (Delete (List.length todo)) ][ text "Delete" ], text (" " ++ new) ] ]

editTodo : Int -> String -> List (Html Msg) -> List (Html Msg)
editTodo index new todo = 
  todo
  |> Array.fromList
  |> Array.set index (li [][ button [ onClick (Edit index) ][ text "Edit" ], button [ onClick (Delete index) ][ text "Delete" ], text (" " ++ new) ])
  |> Array.toList

deleteTodo : Int -> List (Html Msg) -> List (Html Msg)
deleteTodo index todo =
  todo
  |> Array.fromList
  |> Array.Extra.removeAt index --set index Nothing (li [][ button [ onClick (Edit index) ][ text "Edit" ], button [ onClick Delete ][ text "Delete" ], text (" " ++ new) ])
  |> Array.toList

-- VIEW
view : Model -> Html Msg
view model = 
    div [] [
        h2 [][ text ("Todo List For: " ++ model.person) ],
        ol [] model.todo,
        input [ type' "text", placeholder "New Todo Item", onInput Input ][],
        button [ onClick Add ][ text "Add Item" ]
        ]

-- END
