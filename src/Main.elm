module Main exposing (..)

import Browser
import Element
import Element.Input
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)


-- MAIN


main =
  Browser.sandbox { init = init, update = update, view = view }



-- MODEL

type alias Model = Int

init : Model
init =
  0


-- UPDATE

type Msg = Increment | Decrement | Reset

update : Msg -> Model -> Model
update msg model =
  case msg of
    Increment ->
      model + 1

    Decrement ->
      model - 1

    Reset ->
      init


-- VIEW

view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Decrement ] [ text "-" ]
        , div [] [ text (String.fromInt model) ]
        , button [ onClick Increment ] [ text "+" ]
        , Element.layout []
            (Element.Input.button []
                { onPress = Just Reset
                , label = Element.text "Reset"
                }
            )
        ]
