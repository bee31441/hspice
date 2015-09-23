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
findMyNext2Index :: [String] -> String  -> IO [String]
findMyNext2Index xt x = do
                indices <- return $ elemIndices' x xt
                return $ elementsAt xt (map (+2) indices)

stringCombination :: [String] -> [String] -> String -> [String]
stringCombination [] [] z = []
stringCombination (x:xt) [] z = map (++ z) (x:xt)
stringCombination [] (y:yt) z = map (z ++) (y:yt)
stringCombination (x:xt) (y:yt) z = (x ++ z ++ y): (stringCombination xt yt z)

main  = do
    putStrLn "Which file you want to survey?"
    path' <- return $ "../vco.lis"--getLine
    content <- readFile' path'
    contentList <- return $ words content --[string]
    putStrLn "what word you want to use to label(x)"
    words_x <- getLine
    putStrLn "what word you want to search(y)"
    words_y <- getLine
    content_x <- findMyNext2Index contentList words_x
    content_y <- findMyNextIndex contentList words_y
    contentoutput <- return $ map (++ "\n") $ stringCombination (map ((words_x ++ "=") ++) (drop 1 content_x))(map (words_y ++) content_y) "="
    writeFile "newcreation.txt" $ unwords contentoutput
