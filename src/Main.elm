module Main exposing (..)

import Anchor as Anchor
import Browser
import Html exposing (Html)
import Html.Attributes exposing (style)
import Button


type alias Model =
    { test : Int
    }


type Msg
    = NoOP


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOP ->
            ( model, Cmd.none )


init : ( Model, Cmd Msg )
init =
    ( { test = 0
      }
    , Cmd.none
    )


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
    Html.div [ style "max-width" "800px", style "margin" "auto" ]
        [ Html.h1 [] [ Html.text "elm restart" ]
        , Html.h2 [] [ Html.text "Anchor" ]
        , Anchor.anchor [ Anchor.Href "#" ] [] [ Html.text "Anchor link" ]
        , Html.h2 [] [ Html.text "Button" ]
        , Button.button [] [] [ Html.text "Button" ]
        , Button.button [Button.Disabled True] [] [ Html.text "Disabled" ]
        ]
