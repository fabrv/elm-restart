module Main exposing (..)
import Browser
import Html exposing (Html)

import Anchor as Anchor

type alias Model =
  { 
    test : Int
  }

type Msg
  = NoOP

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    NoOP ->
      ( model, Cmd.none )

init : (Model, Cmd Msg)
init = 
  ({
    test = 0
  }, Cmd.none)

main : Program () Model Msg
main =
    Browser.element
        { init = \_ -> init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }

view : Model -> Html Msg
view _ =
  Html.div [] [
    Html.h1 [] [Html.text "elm restart"]
    , Anchor.anchor [Anchor.Href "#"] [] [Html.text "pls work"]
  ]