{-# LANGUAGE OverloadedStrings #-}

module Graphviz.Serve where

import Graphviz.Render

import Web.Scotty
import Control.Monad.IO.Class
import Data.Text.Lazy.Encoding (decodeUtf8)
import Data.ByteString.Base64.Lazy (encode)
import Network.Wai.Middleware.RequestLogger
import Network.Wai.Middleware.Static
import qualified Control.Monad.State as MS

serve :: ScottyM ()
serve = do
  middleware logStdoutDev

  post "/graphviz" $ do
    header "Content-Type" "image/png"
    inp <- body
    outp <- liftIO (render inp >>= return.encode)
    raw outp
  
staticServe :: ScottyM ()
staticServe = do
  middleware $ staticPolicy (addBase "static")
  
run = scotty 3000 (staticServe >> serve)
