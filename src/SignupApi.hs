{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeOperators #-}

module SignupApi where

import           Data.Aeson
import qualified Data.Text as T 
import           Data.Text (Text)
import           Servant

import           GHC.Generics

type SignupAPI = "signup" :> ReqBody '[JSON] User :> Post '[JSON] Token

data User = User
  { username :: Text
  , password :: Text
  , email :: String
  } deriving (Eq, Show, Generic)

instance ToJSON User
instance FromJSON User

data Token = Token 
  { access_token :: Text
  } deriving (Eq, Show, Generic)
instance ToJSON Token
instance FromJSON Token

signupAPI :: Proxy SignupAPI
signupAPI = Proxy

app :: Application
app = serve signupAPI server

server :: Server SignupAPI
server = postUser

postUser :: User -> Handler Token
postUser user = return $ 
  Token { access_token = "Blah1234" }