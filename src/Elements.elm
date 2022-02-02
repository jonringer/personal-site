module Elements exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href, src)


banner : Html msg
banner =
    div [ class "bb mh3 mv1 h3 ct flex justify-between items-center" ]
        [ div [ class "ma1 pa" ]
            [ text "Jon Ringer" ]
        , div []
            [ a [ class "ma2", href "basinix.jonringer.us" ] [ text "Basinix" ]
            , a [ class "ma2", href "blog.jonringer.us" ] [ text "Blog" ]
            , a [ class "ma2", href "hydra.jonringer.us" ] [ text "Hydra" ]
            ]
        ]
