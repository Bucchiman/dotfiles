-- キャッシュされたモジュールを削除
package.loaded['simple_nvim_plugin'] = nil
package.loaded['simple_nvim_plugin/testModule'] = nil

-- モジュールを呼び出す
local simple = require('simple_nvim_plugin')

-- 関数呼び出し
simple.test()
simple.callModule('test')
simple.callModule('')
