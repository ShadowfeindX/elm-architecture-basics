import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Html.App as App


main = App.beginnerProgram {model = model, view = view, update = update}

-- MODEL

type alias Model = Int

model : Model
model = 0

-- UPDATE

type Msg = Reset | Increment | Decrement

update : Msg -> Model -> Model
update msg model = 
    case msg of
        Reset -> 0
        Increment -> model + 1
        Decrement -> model - 1

-- VIEW

view : Model -> Html Msg
view model =
    div [] [
        div [] [ text (toString model) ],
        button [ onClick Decrement ] [ text "-" ],
        button [ onClick Reset ] [ text "0" ],
        button [ onClick Increment ] [ text "+" ]
    ]