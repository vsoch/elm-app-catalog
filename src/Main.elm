module Main exposing (main)

import Browser
import Element
import Element.Background as Background
import Element.Input
import Html exposing (Html)



-- STYLE


marigold : Element.Color
marigold =
    Element.rgb255 252 186 3


green : Element.Color
green =
    Element.rgb255 8 196 27



-- MAIN


main : Program () Model Msg
main =
    Browser.sandbox { init = init, update = update, view = view }


{-| <https://package.elm-lang.org/packages/elm/browser/latest/Browser>
init, update, and view are defined below |
-}



-- MODEL


type alias Model =
    { counter : Int }



-- Model is record that holds an integer counter
-- init is a function that returns an Int (type Model)


init : Model
init =
    { counter = 0 }



-- UPDATE


type Msg
    = Increment
    | Decrement
    | Reset


{-| I think this says that update is a function that takes first a Msg type (e.g.,
Increment) which is a second function (defined within) that also takes
another number (Model type) and then returns a new number (Model) |
-}
update : Msg -> Model -> Model
update message model =
    case message of
        -- Return value +1
        Increment ->
            { counter = model.counter + 1 }

        -- Return value -1
        Decrement ->
            { counter = model.counter - 1 }

        -- Return 0
        Reset ->
            init



-- VIEW


view : Model -> Html Msg
view model =
    Element.layout []
        (Element.column []
            [ Element.Input.button
                [ Background.color marigold
                ]
                { onPress = Just Increment
                , label = Element.text "+"
                }
            , Element.el [] (Element.text (String.fromInt model.counter))
            , Element.Input.button
                [ Background.color marigold
                ]
                { onPress = Just Decrement
                , label = Element.text "-"
                }
            , Element.Input.button
                [ Background.color green
                ]
                { onPress = Just Reset
                , label = Element.text "Reset"
                }
            ]
        )
