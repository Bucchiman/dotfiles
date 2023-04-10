-- テーブル宣言
local M = {}

-- モジュール読み込み
local testModule = require("simple_nvim_plugin/testModule")

-- 関数宣言
function M.test()
    print("hello world");
end

-- モジュールの関数を呼び出す
function M.callModule(str)
    testModule.test(str)
end

-- テーブルを返す
return M
