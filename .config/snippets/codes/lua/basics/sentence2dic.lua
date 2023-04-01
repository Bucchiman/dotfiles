#!/usr/bin/env lua
--
-- FileName:     sentence2dic
-- Author: 8ucchiman
-- CreatedDate:  2023-03-26 23:34:57 +0900
-- LastModified: 2023-03-26 23:36:04 +0900
-- Reference: 8ucchiman.jp
--


t = {}
s = "from=world, to=Lua"
for k, v in s.gmatch("(%w+)=(%w+)")
do
  t[k] = v
end
