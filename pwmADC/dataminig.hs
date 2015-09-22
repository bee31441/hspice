import System.IO
import Data.List
import Data.String

readFile' :: String -> IO String
readFile' path = do
    handle <- openFile path ReadMode  -- will give a handle. Actually One can use "ReadFile", which will simply give IO String
    hGetContents handle -- will conduct the handle

elementAt :: [a] -> Int -> a
elementAt [] x = error"nothing to find"
elementAt xs x = last(take x xs)

elementsAt :: [a] -> [Int] -> [a]
elementsAt xt [] = []
elementsAt xt y:yt = (elementAt xt y) : (elementsAt xt yt)


-- findMyIndex :: [String] -> String  -> String
-- findMyIndex xt x = do
--                 indices <- return $ elemIndices x [xt]
--                 elementAt xt



main  = do
    path' <- getLine
    content <- readFile' path'
    contentList <- return $ words content
    writeFile "newcreation.txt" content
    -- content <- strSplitAll content \b\b
