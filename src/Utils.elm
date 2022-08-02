module Utils exposing (includesEnum)

includesEnum : List Int -> Int -> Bool
includesEnum list searchElement =
  List.length (List.filter (\i -> i == searchElement) list) > 0