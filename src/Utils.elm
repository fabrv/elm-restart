module Utils exposing (includesInt, includesString)


includesInt : List Int -> Int -> Bool
includesInt list searchElement =
    List.length (List.filter (\i -> i == searchElement) list) > 0


includesString : List String -> String -> Bool
includesString list searchElement =
    List.length (List.filter (\i -> i == searchElement) list) > 0
