module Dropdown exposing (Option(..), dropdown)

import Html
import Html.Attributes
import List exposing (map)


type Option
    = Show Bool


attributeMapping : Option -> Html.Attribute msg
attributeMapping option =
    case option of
        Show show ->
            Html.Attributes.style "display"
                (if show then
                    "flex"

                 else
                    "none"
                )


dropdown :
    Html.Html msg
    -> List Option
    -> List (Html.Attribute msg)
    -> List (Html.Html msg)
    -> Html.Html msg
dropdown dropdownToggle options attributes children =
    Html.span []
        [ dropdownToggle
        , Html.div
            (map attributeMapping options
                ++ attributes
                ++ [ Html.Attributes.style "position" "absolute" ]
            )
            children
        ]
