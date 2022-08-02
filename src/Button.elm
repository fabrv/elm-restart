module Button exposing (Option(..), button)

import Html
import Html.Attributes exposing (disabled)
import List exposing (map)
import Utils exposing (includesEnum)


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
        Type _ -> 0
        Disabled _ -> 1
        Role _ -> 2
        TabIndex _ -> 3
        Target _ -> 4
        Rel _ -> 5
        Href _ -> 6

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

button :
    List Option
    -> List (Html.Attribute msg)
    -> List (Html.Html msg)
    -> Html.Html msg
button options attributes children =
    if includesEnum (map enumOption options) 6 then
        Html.a
        (map attributeMapping options
            ++ attributes
        )
        children
    else
        Html.button
            (map attributeMapping options
                ++ attributes
            )
            children
