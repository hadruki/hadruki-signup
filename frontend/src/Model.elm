module Model exposing
  ( SignupUser
  , Model
  , initialModel
  , emptySignupUser
  )

-- MODEL

type alias SignupUser = 
  { username : String
  , email    : String
  , password : String
  }

emptySignupUser = SignupUser "" "" ""

type alias Model =
  { user  : SignupUser
  , token : Maybe String
  , error : Maybe String
  , confirmation : Maybe String
  }

undefinedToken = Nothing
noErrors = Nothing
unconfirmed = Nothing

initialModel : SignupUser -> Model
initialModel initialUser = Model initialUser undefinedToken noErrors unconfirmed
