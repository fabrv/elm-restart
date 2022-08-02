module Main exposing (..)

import Browser
import Button
import Dropdown
import Html exposing (Html)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)


type alias Model =
    { disableButton : Bool
    , showDropdown : Bool
    }


type Msg
    = NoOP
    | ToggleEnable
    | ToggleDropdown


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOP ->
            ( model, Cmd.none )

        ToggleEnable ->
            ( { model | disableButton = not model.disableButton }, Cmd.none )

        ToggleDropdown ->
            ( { model | showDropdown = not model.showDropdown }, Cmd.none )


init : ( Model, Cmd Msg )
init =
    ( { disableButton = True
      , showDropdown = False
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
view model =
    Html.div [ style "max-width" "800px", style "margin" "auto" ]
        [ Html.h1 [] [ Html.text "elm restart" ]
        , Html.h2 [] [ Html.text "Button" ]
        , Button.button [] [ onClick ToggleEnable ] [ Html.text "Button" ]
        , Button.button [ Button.Disabled model.disableButton ] [] [ Html.text "Disabled" ]
        , Button.button [ Button.Href "#" ] [] [ Html.text "I'm a link" ]
        , Html.h2 [] [ Html.text "Dropdown" ]
        , Dropdown.dropdown
            (Button.button [] [onClick ToggleDropdown] [ Html.text "Open toggle" ])
            [ Dropdown.Show model.showDropdown ]
            [   style "background-color" "white" 
            ,   style "border-radius" "5px"
            ,   style "flex-direction" "column"
            ]
            [   Button.button [] [] [Html.text "Action item"]
            ,   Button.button [] [] [Html.text "Action item 2"]
            ]
        ]
