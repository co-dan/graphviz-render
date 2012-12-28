{-# LANGUAGE ScopedTypeVariables #-}

module Graphviz.Render (render) where

import qualified Data.ByteString.Lazy.Char8 as BL
import System.IO
import System.Directory (getTemporaryDirectory, removeFile)
import System.Process
import Control.Exception as CE

render :: BL.ByteString -> IO BL.ByteString
render dat = do
  withTempFile "graphviz.dot" $ 
    \path hndl -> do
      writeData dat hndl
      hClose hndl
      (_,_,_,p) <- createProcess (proc "dot" [path, "-Tpng", "-O"])
      waitForProcess p
      BL.readFile (path ++ ".png")
  
writeData :: BL.ByteString -> Handle -> IO ()
writeData dat hndl = BL.hPut hndl dat
                          
withTempFile :: String -> (FilePath -> Handle -> IO a) -> IO a
withTempFile pattern func = do
  tempdir <- CE.catch (getTemporaryDirectory) (\(_ :: IOException) -> return ".")
  (tempfile, temph) <- openTempFile tempdir pattern 

  finally (func tempfile temph) 
    (do hClose temph
        removeFile tempfile)

