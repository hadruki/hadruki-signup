module Main where

import SignupApi

import Network.Wai
import Network.Wai.Handler.Warp

main :: IO ()
main = run 3002 app
