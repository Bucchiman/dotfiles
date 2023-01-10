#!/usr/bin/env lua
--
-- FileName:     utils
-- CreatedDate:  2023-01-05 23:39:49 +0900
-- LastModified: 2023-01-07 13:49:25 +0900
--


a = "one string"
b = string.gsub(a, "one", "another")
print(a)
print(b)

line = io.read()
n = tonumber(line)
print(n)


--a = {}
--for i=1, 10 do
--  a[i] = io.read()
--end

a = {}
a[1] = "hoge"
a[2] = "hige"
a[3] = "geho"
a[4] = "jhih"
for i, line in ipairs(a) do 
  print(line)
end


-- list = nil
-- for line in io.lines() do
--   list = {next=list, value=line}
-- end


local launch_menu = {}
table.insert(launch_menu, {
  label = "hoge",
  args = {"hoge"},})

for i=1, #launch_menu do
  print(launch_menu[i])
end
print(#launch_menu)
