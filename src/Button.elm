module Button exposing (Option(..), button)

import Html
import Html.Attributes exposing (disabled)
import List exposing (map)


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


button :
    List Option
    -> List (Html.Attribute msg)
    -> List (Html.Html msg)
    -> Html.Html msg
button options attributes children =
    Html.button
        (map attributeMapping options
            ++ attributes
        )
        children
