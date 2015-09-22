import System.IO
import Data.List

readFile' :: String -> IO String
readFile' path = do
    handle <- openFile path ReadMode  -- will give a handle. Actually One can use "ReadFile", which will simply give IO String
    hGetContents handle -- will conduct the handle



main  = do
    path' <- getLine
    content <- readFile' path'
    print content
