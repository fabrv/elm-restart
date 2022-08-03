module Button exposing (ButtonType(..), Option(..), button, useButtonAttributes)

import Html
import Html.Attributes exposing (disabled)
import List exposing (map)
import Utils exposing (includesInt)


type ButtonType
    = Button
    | Reset
    | Submit


type Option
    = Type ButtonType
    | Disabled Bool
    | Role String
    | TabIndex Int
    | Target String
    | Rel String
    | Href String


enumOption : Option -> Int
enumOption option =
    case option of
        Type _ ->
            0

        Disabled _ ->
            1

        Role _ ->
            2

        TabIndex _ ->
            3

        Target _ ->
            4

        Rel _ ->
            5

        Href _ ->
            6


attributeMapping : Option -> Html.Attribute msg
attributeMapping option =
    case option of
        Type type_ ->
            Html.Attributes.type_
                (case type_ of
                    Button ->
                        "button"

                    Reset ->
                        "reset"

                    Submit ->
                        "submit"
                )

        Disabled disabled ->
            Html.Attributes.disabled disabled

        Role role ->
            Html.Attributes.attribute "role" role

        TabIndex tabIndex ->
            Html.Attributes.attribute "tab-index" (String.fromInt tabIndex)

        Target target ->
            Html.Attributes.target target

        Rel rel ->
            Html.Attributes.rel rel

        Href href ->
            Html.Attributes.href href


useButtonAttributes : List Option -> ( List (Html.Attribute msg), List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg )
useButtonAttributes options =
    let
        enum =
            map enumOption options

        attributes =
            map attributeMapping options

        isLink =
            includesInt enum 4 || includesInt enum 5 || includesInt enum 6
    in
    ( (if isLink then
        [ Html.Attributes.attribute "role" "button"
        , Html.Attributes.type_ "button"
        , Html.Attributes.tabindex 0
        ]

       else
        [ Html.Attributes.type_ "button" ]
      )
        ++ attributes
    , if isLink then
        Html.a

      else
        Html.button
    )


button :
    List Option
    -> List (Html.Attribute msg)
    -> List (Html.Html msg)
    -> Html.Html msg
button options attributes children =
    let
        ( ariaButtonAttributes, tag ) =
            useButtonAttributes options
    in
    tag (ariaButtonAttributes ++ attributes) children
