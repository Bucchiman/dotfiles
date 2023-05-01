#!/usr/bin/env lua
--
-- FileName:     _plugin_name
-- Author:       8ucchiman
-- Email:        8ucchiman@gmail.com
-- CreatedDate:  2023-05-01 16:31:25
-- LastModified: 2023-01-23 14:18:33 +0900
-- Reference:    8ucchiman.jp
-- Description:  ---
--


local module = require("_plugin_name.module")

local M = {}
M.config = {
    opt = "Hello",
}


M.Bucchiman = function(args)
    M.config = vim.tbl_deep_extend("force", M.config, args or {})
end

M.hello = function()
    module.my_first_function()
end

return M
