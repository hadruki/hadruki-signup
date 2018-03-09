module Update exposing 
  ( update
  , subscriptions
  )

import Http
import Json.Encode as Encode
import Json.Decode as Decode exposing (Decoder, int)
import Json.Decode.Pipeline as Decode exposing (decode, required)
import Maybe

import Model exposing (..)
import Msg exposing (..)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Name name ->
      -- Update the user username
      let modelUser = model.user
      in (initialModel <| { modelUser | username = name }, Cmd.none)

    Email email -> 
      -- Update the user email
      let modelUser = model.user
      in ({ model | user = { modelUser | email = email } }, Cmd.none)

    Password password ->
      -- Update the password
      let modelUser = model.user
      in ({ model | user = { modelUser | password = password } }, Cmd.none)
      
    Submit -> (initialModel model.user, signup model.user)
    
    SignupResult (Ok user) -> 
      ({ model | token = Just user.token }, Cmd.none)
      
    SignupResult (Err err) ->
      let errorMsg = showError err 
      in ({ model | error = Just errorMsg }, Cmd.none)


subscriptions : Model -> Sub Msg
subscriptions model = Sub.none

--- Encoding / Decoding

signup : SignupUser -> Cmd Msg
signup user =
  let
    url = "http://localhost:3000/signup"
    encodedSignupUser = encodedSignup user
    body    = Http.jsonBody encodedSignupUser
    request =
      Http.post url body signupResponseDecoder
  in
    Http.send SignupResult request

signupResponseDecoder : Decode.Decoder User
signupResponseDecoder =
  Decode.decode User 
    |> Decode.required "username" Decode.string
    |> Decode.required "email"    Decode.string
    |> Decode.required "token"    Decode.string
    

encodedSignup : SignupUser -> Encode.Value 
encodedSignup user = Encode.object [
                        ("username", Encode.string user.username)
                      , ("email"   , Encode.string user.email)
                      , ("password", Encode.string user.password) 
                    ]

--- Utility
showError : Http.Error -> String
showError error = case error of 
                    Http.BadUrl msg             -> "Bad url: " ++ msg
                    Http.Timeout                -> "Timeout"
                    Http.NetworkError           -> "Network error"
                    Http.BadStatus resp         -> "Bad status: " ++ (toString resp.status.code) ++ " " ++ resp.status.message
                    Http.BadPayload msg1 resp   -> "Bad payload: " ++ msg1 ++ " from " ++ resp.body 