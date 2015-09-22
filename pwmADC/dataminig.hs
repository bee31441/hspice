import System.IO
import Data.List
import Data.String

readFile' :: String -> IO String
readFile' path = do
    handle <- openFile path ReadMode  -- will give a handle. Actually One can use "ReadFile", which will simply give IO String
    hGetContents handle -- will conduct the handle

elemIndices' :: Eq a => a -> [a] -> [Int]
elemIndices' x xt = map (+1) $ elemIndices x xt

elementAt :: [a] -> Int -> a
elementAt [] x = error"nothing to find"
elementAt xs x = last(take x xs)

elementsAt :: [a] -> [Int] -> [a]
elementsAt xt [] = []
elementsAt xt (y:yt) = (elementAt xt y) : (elementsAt xt yt)


findMyIndex :: [String] -> String  -> IO [String]
findMyIndex xt x = do
                indices <- return $ elemIndices' x xt
                return $ elementsAt xt indices

findMyNextIndex :: [String] -> String  -> IO [String]
findMyNextIndex xt x = do
                indices <- return $ elemIndices' x xt
                return $ elementsAt xt (map (+1) indices)

main  = do
    putStrLn "Which file you want to survey?"
    path' <- getLine
    content <- readFile' path'
    contentList <- return $ words content --[string]
    wordsneed <- getLine
    contentneed <- findMyNextIndex contentList wordsneed
    contentoutput <- return $ map (wordsneed ++) $ map (++"\n") contentneed
    writeFile "newcreation.txt" $ unwords contentoutput
