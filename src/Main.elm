module Main exposing (main)

import Browser
import Element
import Element.Background as Background
import Element.Input
import Element.Region
import Html exposing (Html)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode exposing (Decoder, field, string)


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
    { status : SubState}



-- Model is record that holds an integer counter, and a status for loading apps
-- init is a function that returns an Int (type Model)


init : () -> ( Model, Cmd Msg )
init _ =
    ( { status = Loading }
    , getRandomCatGif
    )



-- UPDATE


type Msg
    = MorePlease
    | GotGif (Result Http.Error String)



{-| I think this says that update is a function that takes first a Msg type (e.g.,
Increment) which is a second function (defined within) that also takes
another number (Model type) and then returns a new number (Model) |
-}
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    -- Handle the API request first
    case msg of
        MorePlease ->
            ( { model | status = Loading }, getRandomCatGif )

        GotGif result ->
            case result of
                Ok url ->
                    ( { model | status = Success url }, Cmd.none )

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
              Element.Region.heading 2
              { label = Element.text "Random Cats" }
             , viewGif model
            ]
        )

viewGif : Model -> Html Msg
viewGif model =
    case model.status of
        Failure ->
          [ Element.el []
              (Element.text "I could not load a random cat.")
              , Element.Input.button
                [ Background.color marigold
                ]
                { onPress = MorePlease
                , label = Element.text "Try Again"
                }
          ]  
        Loading ->
          [ Element.el []
              (Element.text "Loading")
          ]  
        Success url ->
          [ Element.el []
              (Element.Input.button
                [ Background.color marigold
                ]
                { onPress = MorePlease
                , label = Element.text "More Please"
                }
               ,Element.image 200 200 url)
          ]


-- HTTP


getRandomCatGif : Cmd Msg
getRandomCatGif =
  Http.get
    { url = "https://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=cat"
    , expect = Http.expectJson GotGif gifDecoder
    }


gifDecoder : Decoder String
gifDecoder =
  field "data" (field "image_url" string)
