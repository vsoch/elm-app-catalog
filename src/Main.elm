module Main exposing (..)

import Browser
import Element
import Element exposing (rgb255)
import Element.Input
import Element.Background as Background
import Html exposing (Html, div, text)
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

type alias Counter = Int
-- Counter is an alias for an Int (or Counter is of type Int)

-- init is a function that returns an Int (type Model)
init : Counter
init =
  0


-- UPDATE

type Action = Increment | Decrement | Reset

{-| I think this says that update is a function that takes first an Action type (e.g.,
    Increment) which is a second function (defined within) that also takes
    another number (Counter type) and then returns a new number (Counter) |-}
update : Action -> Counter -> Counter
update action counter =
  case action of

    -- Return value +1
    Increment ->
      counter + 1

    -- Return value -1
    Decrement ->
      counter - 1

    -- Return 0
    Reset ->
      init


-- VIEW

view : Counter -> Html Action
view counter =
    div []
        [ Element.layout []
            (Element.Input.button [
               -- How do I add padding here (other style)?
               Background.color marigold
              ]
              { onPress = Just Decrement
              , label = Element.text "-"
              }
            )
        , div [] [ text (String.fromInt counter) ]
        , Element.layout []
            (Element.Input.button [
                Background.color marigold
              ]
              { onPress = Just Increment
              , label = Element.text "+"
              }
            )
        , Element.layout []
            (Element.Input.button [
                  Background.color green
                ]
                { onPress = Just Reset
                , label = Element.text "Reset"
                }
            )
        ]
