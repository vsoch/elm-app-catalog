module Main exposing (..)

import Browser
import Element
import Element exposing (rgb255)
import Element.Input
import Element.Background as Background
import Html exposing (Html, div)
import Html.Events exposing (onClick)

-- STYLE

marigold =
    Element.rgb255 252 186 3

green =
    Element.rgb255 8 196 27

-- MAIN

main =
  Browser.sandbox { init = init, update = update, view = view }

{-| https://package.elm-lang.org/packages/elm/browser/latest/Browser
    init, update, and view are defined below |-}


-- MODEL

type alias Model = Int
-- Model is an alias for an Int (or Model is of type Int)

-- init is a function that returns an Int (type Model)
init : Model
init =
  0


-- UPDATE

type Msg = Increment | Decrement | Reset

{-| I think this says that update is a function that takes first a Msg type (e.g.,
    Increment) which is a second function (defined within) that also takes
    another number (Model type) and then returns a new number (Model) |-}
update : Msg -> Model -> Model
update message model =
  case message of

    -- Return value +1
    Increment ->
      model + 1

    -- Return value -1
    Decrement ->
      model - 1

    -- Return 0
    Reset ->
      init


-- VIEW

view : Model -> Html Msg
view model =
    Element.layout []
    (Element.column []
        [Element.Input.button [
             -- How do I add padding here (other style)?
             Background.color marigold
        ]
        { onPress = Just Decrement
        , label = Element.text "-"
        }
        ,Element.el [] (Element.text (String.fromInt model))
        ,Element.Input.button [
            Background.color marigold
        ]
        { onPress = Just Increment
        , label = Element.text "+"
        }
        ,Element.Input.button [
             Background.color green
         ]
         { onPress = Just Reset
         , label = Element.text "Reset"
         }
        ]
    )
