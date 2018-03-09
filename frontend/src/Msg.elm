module Msg exposing
  ( Msg(..)
  , User
  )

import Http

type alias User = 
  { username : String
  , email    : String
  , token    : String
  }

type Msg
    = Name String
    | Email String
    | Password String
    | Submit
    | SignupResult (Result Http.Error User)

