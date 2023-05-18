<!--
 FileName:      README
 Author:        8ucchiman
 CreatedDate:   2023-05-01 16:01:22
 LastModified:  2023-01-25 10:56:12 +0900
 Reference:     https://github.com/ellisonleao/nvim-plugin-template.git
 Description:   ---
-->


# 各ファイルの概要

```
.
├── lua
│   ├── plugin_name
│   │   └── module.lua
│   └── plugin_name.lua
├── Makefile
├── plugin
│   └── plugin_name.lua
├── README.md
├── tests
│   ├── minimal_init.lua
│   └── plugin_name
│       └── plugin_name_spec.lua
```

### `tests/minimal_init.lua`
- startpoint
- makefileから呼び出される
- `runtime .`により`tests`ディレクトリ


# 使い方
```bash
    $ make test
    $ make rename ARG=nujabes
```
