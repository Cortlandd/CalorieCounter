module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.App as App
import String exposing (toInt)

-- Model
-- The Model is a container containing
-- the raw data the application needs.

type alias Model =
  { calories : Int
  , input : Int
  , error : Maybe String
  }

-- Basically a function to clear the calorie number
initModel : Model
initModel =
  -- Model 0 0 Nothing
  {
    calories = 0
  , input = 0
  , error = Nothing
  }

-- Update
{-
-What things can happen in the app?
-How do those things change the model?

-Union type represent all the things that
could happen in the app.

-Must return a new updated model.
-}

type Msg = AddCalorie | Input String | Clear

update : Msg -> Model -> Model
update msg model = case msg of
  AddCalorie ->
    {
      model
      | calories = model.calories + model.input
      , input = 0
    }

  Input val ->
    case String.toInt val of
      Ok input ->
        {
          model
            | input = input
            , error = Nothing
        }

      Err err ->
        {
          model
          | input = 0
          , error = Just err
        }

  Clear ->
    initModel


--View
{-
Basically creating the Html considering the current
state of the app.


-}

view : Model -> Html Msg
view model =
  div []
      [
      h3 []
        [ text ("Total Calories: " ++ (toString model)) ]
      , input
          [ type' "text"
          , onInput Input
          , value
            (if model.input == 0 then
              ""
            else
              toString model.input
            )
          ] []
      , div [] [text (Maybe.withDefault "" model.error) ]
      , button
          [ type' "button", onClick AddCalorie ]
          [ text "Add" ]
      , button
          [ type' "button", onClick Clear ]
          [ text "Clear" ]
      ]


main : Program Never
main =
  App.beginnerProgram
    { model = initModel
    , update = update
    , view = view
    }
