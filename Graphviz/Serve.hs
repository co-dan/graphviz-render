{-# LANGUAGE OverloadedStrings #-}

module Graphviz.Serve where

import Graphviz.Render

import Web.Scotty
import Control.Monad.IO.Class
import Data.Text.Lazy.Encoding (decodeUtf8)
import Network.Wai.Middleware.RequestLogger
import qualified Control.Monad.State as MS

serve :: ScottyM ()
serve = do
  middleware logStdoutDev

  post "/graphviz" $ do
    header "Content-Type" "image/png"
    inp <- body
    outp <- liftIO (render inp)
    raw outp
  
run = scotty 3000 serve
