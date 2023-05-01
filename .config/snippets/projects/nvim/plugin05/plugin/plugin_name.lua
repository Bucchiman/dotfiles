#!/usr/bin/env lua
--
-- FileName:     plugin_name
-- Author:       8ucchiman
-- Email:        8ucchiman@gmail.com
-- CreatedDate:  2023-05-01 10:57:08
-- LastModified: 2023-01-23 14:18:33 +0900
-- Reference:    8ucchiman.jp
-- Description:  ---
--



vim.api.nvim_create_user_command("MyFirstFunction", require("plugin_name").hello, {})

