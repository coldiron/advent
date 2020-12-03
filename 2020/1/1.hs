main :: IO ()
main = do
  infile <- readFile "input"
  let xs = [read x :: Int | x <- lines infile]
  print $ [a * b |  a <- xs, b <- xs , a + b == 2020]
  print $ [a * b * c |  a <- xs, b <- xs, c <- xs , a + b + c == 2020]