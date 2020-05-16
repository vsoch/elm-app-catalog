module Main exposing (main)

import Browser
import Element
import Element.Background as Background
import Element.Input
import Html exposing (Html, pre, text)
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
    Browser.sandbox { init = init, update = update, view = view, apps = apps }


{-| <https://package.elm-lang.org/packages/elm/browser/latest/Browser>
init, update, and view are defined below |
-}



-- MODEL


type AppState
    = Failure
    | Loading
    | Success String


type alias Model =
    { counter : Int
    , status : AppState
    }



-- Model is record that holds an integer counter, and a status for loading apps
-- init is a function that returns an Int (type Model)


init : () -> ( Model, Cmd AppMsg )
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
-- this is saying GotText can be a result, error, OR string?


type AppMsg
    = GotText (Result Http.Error String)


type CounterMsg
    = Increment
    | Decrement
    | Reset


type alias Msg =
    { app : AppMsg
    , counter : CounterMsg
    }


{-| I think this says that update is a function that takes first a Msg type (e.g.,
Increment) which is a second function (defined within) that also takes
another number (Model type) and then returns a new number (Model) |
-}
update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    -- Handle the API request first
    case message.app of
        GotText result ->
            case result of
                Ok fullText ->
                    case message.counter of
                        -- Return value +1
                        Increment ->
                            ( { counter = model.counter + 1
                              , status = Success fullText
                              }
                            , Cmd.none
                            )

                        -- Return value -1
                        Decrement ->
                            ( { counter = model.counter - 1
                              , status = Success fullText
                              }
                            , Cmd.none
                            )

                        -- Return 0
                        Reset ->
                            ( { counter = 0
                              , status = Success fullText
                              }
                            , Cmd.none
                            )

                -- Cmd.none means there is nothing left to do
                Err _ ->
                    case message.counter of
                        -- Return value +1
                        Increment ->
                            ( { counter = model.counter + 1
                              , status = Failure
                              }
                            , Cmd.none
                            )

                        -- Return value -1
                        Decrement ->
                            ( { counter = model.counter - 1
                              , status = Failure
                              }
                            , Cmd.none
                            )

                        -- Return 0
                        Reset ->
                            ( { counter = 0
                              , status = Failure
                              }
                            , Cmd.none
                            )



-- APPS


apps : Model -> Sub Msg
apps model =
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
                            Element.text "I was unable to load the text!"

                        Loading ->
                            Element.text "Loading..."

                        Success fullText ->
                            Element.text fullText
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
