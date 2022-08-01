module DataKey exposing (..)

attributePrefix : String
attributePrefix = "data-er-ui-"

propertyPrefix : String
propertyPrefix = "erUi"

dataAttr: String -> String
dataAttr name = attributePrefix ++ name

dataProps: String -> String
dataProps name = propertyPrefix ++ name