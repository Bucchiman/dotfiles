#!/usr/bin/env lua
--
-- FileName:     sentence2words
-- Author: 8ucchiman
-- CreatedDate:  2023-03-26 23:31:46 +0900
-- LastModified: 2023-03-26 23:34:38 +0900
-- Reference: 8ucchiman.jp
--



s = "hello world from Lua"
for w in s.gmatch("%a+") do
  print(w)
end
