module Main exposing (..)

import Browser
import Button
import Dropdown
import Html exposing (Html, code, div, h1, h2, h3, li, p, pre, text, ul)
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


buttonSection : Model -> Html Msg
buttonSection model =
    div []
        [ h2 [] [ text "Button" ]
        , p [] [ text "An abstract button component for creating accessible buttons regardless of the HTML element used to render it." ]
        , Button.button [] [ onClick ToggleEnable ] [ text "Click me" ]
        , Button.button [ Button.Disabled model.disableButton ]
            []
            [ text
                ("I'm "
                    ++ (if model.disableButton then
                            "disabled"

                        else
                            "enabled"
                       )
                )
            ]
        , Button.button [ Button.Type Button.Submit ] [] [ text "I'm submit" ]
        , pre [] [ code [] [ text "[ Button.button [] [ onClick ToggleEnable ] [ text \"I'm a Button\" ]\n, Button.button [ Button.Disabled False ] [] [ text \"I'm disabled\" ]\n]" ] ]
        , p [] [ text "Not very impressive on its own, but Button does come with a few conveniences over the plain HTML element." ]
        , ul []
            [ li [] [ text "type defaults to button" ]
            , li [] [ text "Ensures that non button as options remain accessible" ]
            , li [] [ text "contextually renders an <a> if href is added." ]
            ]
        , Button.button [] [] [ text "I'm a Button" ]
        , Button.button [ Button.Href "#" ] [] [ text "I'm a link" ]
        , pre [] [ code [] [ text "[ Button.button [] [ ] [ text \"I'm a Button\" ]\n, Button.button [ Button.Href \"#\" ] [] [ text \"I'm a link\" ]\n]" ] ]
        , h3 [] [ text "useButtonAttributes" ]
        , p [] [ text "Most of the heavy lifting in Button comes from the useButtonAttributes function. You can use the function directly to turn any component into an accessible button." ]
        , p [] [ text "The function will pick between 'button' and 'a' depending on whether any anchor specific options, like href, were provided. But you can put the attributes on any tag." ]
        , pre [] [ code [] [ text "companyButton :\n    -> List (Html.Attribute msg)\n    -> List (Html.Html msg)\n    -> Html.Html msg\ncompanyButton attributes children =\n    let\n        ( ariaButtonAttributes, tag ) =\n            useButtonAttributes []\n    in\n    tag (ariaButtonAttributes ++ attributes) children" ] ]
        ]


view : Model -> Html Msg
view model =
    div [ style "max-width" "800px", style "margin" "auto" ]
        [ h1 [] [ text "elm restart" ]
        , buttonSection model
        , h2 [] [ text "Dropdown" ]
        , Dropdown.dropdown
            (Button.button [] [ onClick ToggleDropdown ] [ text "Open toggle" ])
            [ Dropdown.Show model.showDropdown ]
            [ style "background-color" "white"
            , style "border-radius" "5px"
            , style "flex-direction" "column"
            ]
            [ Button.button [] [] [ text "Action item" ]
            , Button.button [] [] [ text "Action item 2" ]
            ]
        ]
