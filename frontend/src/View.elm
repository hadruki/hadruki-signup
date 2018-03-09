module View exposing
  ( view
  )

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Maybe
import Formatting as Fmt exposing (..)
import Json.Encode as Json

import Model exposing (..)
import Msg exposing (..)

-- VIEW

{--
<div class="container">
<h2 class="text-center text-uppercase text-secondary mb-0">Contact Me</h2>
<hr class="star-dark mb-5">
<div class="row">
  <div class="col-lg-8 mx-auto">
    <form name="sentMessage" id="contactForm" novalidate="novalidate">
      ...
      <br>
      <div id="success"></div>
      <div class="form-group">
        <button type="submit" class="btn btn-primary btn-xl" id="sendMessageButton">Send</button>
      </div>
    </form>
  </div>
</div>
</div>
--}
view : Model -> Html Msg
view model =
      div [ class "container" ] [
          h2 [ class "text-center text-uppercase text-secondary mb-0"] [ text "Sign Up" ]
        , hr [ class "star-dark mb-5"] [] 
        , div [ class "row" ] [
            div [ class "col-lg-8 mx-auto" ] [
              viewConfirmation model
              , Html.form [ name "signup", id "signupForm", novalidate True ] [
                  inputBox "name" "Name" "text" Name
                , inputBox "email" "Email" "email" Email
                , inputBox "password" "Password" "password" Password
                , button [ onClick Submit ] [ text "Sign up!" ]
                , viewToken model
                , viewError model
                , viewValidation model
                ]
            ]
        ]
      ]

{-- 
  <div class="control-group">
    <div class="form-group floating-label-form-group controls mb-0 pb-2">
      <label>Email Address</label>
      <input class="form-control" id="email" type="email" placeholder="Email Address" required="required" data-validation-required-message="Please enter your email address.">
      <p class="help-block text-danger"></p>
    </div>
  </div>
--}
inputBox inputid labeltext inputtype msg =
    div [ class "control-group" ] [
        div [ class "form-group floating-label-form-group controls mb-0 pb-2"] [
            label [] [text labeltext]
            , input [ class "form-control", id inputid, type_ inputtype, placeholder labeltext, required True, dataValidationRequiredMessage ("Please enter the " ++ labeltext ++ " field"), onInput msg ] [] 
            , p [ class "help-block text-danger" ] []
        ]
    ]

dataValidationRequiredMessage : String -> Attribute msg
dataValidationRequiredMessage msg =
  stringProperty "data-validation-required-message" msg


stringProperty : String -> String -> Attribute msg
stringProperty name string =
  property name (Json.string string)
      

viewToken : Model -> Html msg
viewToken model = div [] 
                      [ label [ 
                                style [("display", "none")]
                              ] 
                              [ text <| String.append "<token>: " <| Maybe.withDefault "<none>" model.token ]
                      ]

viewConfirmation : Model -> Html msg
viewConfirmation model =
  case model.token of 
    Nothing -> div [] [ p [] [ text "confirmation" ] ]
    Just tok -> 
          let user = model.user
              username = user.username
          in  div [] 
              [ label [] 
                      [ text (print confirmationMessage username) ]
              ]

viewError : Model -> Html msg
viewError model =
  case model.error of 
    Nothing -> div [] []
    Just err -> 
          div [] 
              [ label [] 
                      [ text err ]
              ]

viewValidation : Model -> Html msg
viewValidation model = div [ style [("color", "green")] ] [ text "" ]

confirmationMessage =
    Fmt.s "Hello " <> Fmt.string <> Fmt.s "!" <> Fmt.s " Thanks for signing up!"
