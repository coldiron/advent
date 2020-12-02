import System.IO  

addsTo2020 (a, b) = a + b == 2020

getPair numbers pos = (head numbers, numbers !! pos)


checkPair numbers pos
    | addsTo2020 pair = pair
    | addsTo2020 checkPair numbers (pos + 1) = (0, 0)
    | addsTo2020 checkPair (tail numbers) 0 = (0, 0)
    where pair = getPair numbers pos

main = do  
    handle <- openFile "input" ReadMode  
    contents <- hGetContents handle  
    let numbers = lines handle
    hClose handle  