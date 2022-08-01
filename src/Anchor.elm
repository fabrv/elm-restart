module Anchor exposing (Option(..), anchor)

import Html
import Html.Attributes
import List exposing (map)


type Option
    = Href String
    | Disabled Bool
    | Role String
    | TabIndex Int


attributeMapping : Option -> Html.Attribute msg
attributeMapping option =
    case option of
        Href href ->
            Html.Attributes.href href

        Disabled disabled ->
            Html.Attributes.disabled disabled

        Role role ->
            Html.Attributes.attribute "role" role

        TabIndex tabIndex ->
            Html.Attributes.tabindex tabIndex


anchor :
    List Option
    -> List (Html.Attribute msg)
    -> List (Html.Html msg)
    -> Html.Html msg
anchor options attributes children =
    Html.a
        (map attributeMapping options
            ++ attributes
        )
        children
