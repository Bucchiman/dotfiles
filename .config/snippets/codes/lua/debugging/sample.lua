#!/usr/bin/env lua
--
-- FileName:     sample
-- Author: 8ucchiman
-- CreatedDate:  2023-03-26 22:25:03 +0900
-- LastModified: 2023-03-26 22:25:12 +0900
-- Reference: 8ucchiman.jp
--



function myfunction ()
   print(debug.traceback("Stack trace"))
   print(debug.getinfo(1))
   print("Stack trace end")

   return 10
end

myfunction ()
print(debug.getinfo(1))
