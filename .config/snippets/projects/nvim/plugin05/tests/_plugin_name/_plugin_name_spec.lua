#!/usr/bin/env lua
--
-- FileName:     _plugin_name_spec
-- Author:       8ucchiman
-- Email:        8ucchiman@gmail.com
-- CreatedDate:  2023-05-01 16:29:40
-- LastModified: 2023-01-23 14:18:33 +0900
-- Reference:    8ucchiman.jp
-- Description:  ---
--


local plugin = require("_plugin_name")

describe("setup", function()
    it("works with default", function()
        assert("8ucchiman was here!", plugin.hello())
    end)
end)
