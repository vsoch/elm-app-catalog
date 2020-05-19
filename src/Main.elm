module Main exposing (main)

import Browser
import Element
import Element.Background as Background
import Element.Input
import Html exposing (Html)
import Http



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
    Browser.element { init = init, update = update, view = view, subscriptions = subscriptions }


{-| <https://package.elm-lang.org/packages/elm/browser/latest/Browser>
init, update, and view are defined below |
-}



-- MODEL


type SubState
    = Failure
    | Loading
    | Success String


type alias Model =
    { counter : Int
    , status : SubState
    }



-- Model is record that holds an integer counter, and a status for loading apps
-- init is a function that returns an Int (type Model)


init : () -> ( Model, Cmd Msg )
init _ =
    ( { counter = 0
      , status = Loading
      }
    , Http.get
        { url = "https://elm-lang.org/assets/public-opinion.txt"
        , expect = Http.expectString GotText
        }
    )



-- UPDATE


type Msg
    = Increment
    | Decrement
    | Reset
    | GotText (Result Http.Error String)


{-| I think this says that update is a function that takes first a Msg type (e.g.,
Increment) which is a second function (defined within) that also takes
another number (Model type) and then returns a new number (Model) |
-}
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    -- Handle the API request first
    case msg of
        Increment ->
            ( { model | counter = model.counter + 1 }, Cmd.none )

        Decrement ->
            ( { model | counter = model.counter - 1 }, Cmd.none )

        Reset ->
            ( { model | counter = 0 }, Cmd.none )

        GotText result ->
            case result of
                Ok fullText ->
                    ( { model | status = Success fullText }, Cmd.none )

                -- Cmd.none means there is nothing left to do
                Err _ ->
                    ( { model | status = Failure }, Cmd.none )



-- APPS


subscriptions _ =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    Element.layout []
        (Element.column []
            [ Element.el []
                (Element.text
                    (case model.status of
                        Failure ->
                            "I was unable to load the text!"

                        Loading ->
                            "Loading..."

                        Success fullText ->
                            fullText
                    )
                )
            , Element.Input.button
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
