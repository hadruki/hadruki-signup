module Main exposing 
  ( main )

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Encode as Encode
import Json.Decode as Decode exposing (Decoder, int)
import Json.Decode.Pipeline as Decode exposing (decode, required)
import Maybe
import Formatting as Fmt exposing (..)

import Model exposing (..)
import Msg exposing (..)
import View exposing (..)
import Update exposing (..)

main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

init : (Model, Cmd Msg)
init =
  (initialModel emptySignupUser, Cmd.none)

