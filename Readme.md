# Wxapp.vim

微信小程序开发 vim 插件。

提供包含文件检测、语法高亮、缩进、代码段、单词列表、语法检查等功能支持。

![one](https://cloud.githubusercontent.com/assets/251450/18817567/1bf3c1a0-8396-11e6-81b0-46de8b86acca.gif)

文件生成

![two](https://cloud.githubusercontent.com/assets/251450/18817568/222c1180-8396-11e6-9bed-a175d81f201f.gif)

插入代码块

![three](https://cloud.githubusercontent.com/assets/251450/18817569/27e7db54-8396-11e6-85e2-3f82fc07365e.gif)

使用 [unite](https://github.com/Shougo/unite.vim) 查找并插入代码

## 功能列表

* 页面目录生成的命令
* 刷新和重建开发者工具的快捷键命令 (使用 osascript, 仅支持 macos)
* wxml 和 wxss 文件检测, 代码高亮, 缩进设置 (推荐快捷键 `=at` `=a{`)
* wxml, wxss 以及 javascript dictionary 文件, 使用参考：[vim dictionary 的使用方式](https://chemzqm.me/vim-dictionary)
* wxml 和 javascript [Ultisnips](https://github.com/SirVer/ultisnips) 代码块补全
* wxml 和 wxss 的语法检查支持

## 目录生成

使用命令 `Wxgen [folder] name` 可以快速生成并打开一个页面所需的 `wxml` `wxss`
以及 `javascript` 文件，例如：

```
:Wxgen component product
```

将在 component 目录下生成 product 目录以及相关的三个文件并打开，如果命令只有一个参数则在当前目录下生成。

## 刷新/重建当前项目

只需要 `.vimrc` 中添加一个映射：

```
nmap <leader>r <Plug>WxappReload
```

就可以使用快捷键就行刷新开发者工具的操作了，函数内部做了判定，如果当前文件类型为 `wxml` 或 `wxss` 时执行刷新操作，否则执行项目重建操作。

因为实现用到了 MacOS 独有的 `osascript`，所以只能在 Mac 系统上正常使用。

如果需要保存时让开发者工具自动刷新，请参考：https://chemzqm.me/vim-wxapp-reload

## xml 编辑推荐插件：

* [xml.vim](http://www.vim.org/scripts/script.php?script_id=1397) 用于辅助编辑 xml 文件, 包含自动添加匹配标签、快速修改/删除标签等功能。
* [emmet-vim](https://github.com/mattn/emmet-vim) 快速生成 xml 和 css,
  我的配置：

    ``` vim
      let g:user_emmet_settings = {
      \ 'wxss': {
      \   'extends': 'css',
      \ },
      \ 'wxml': {
      \   'extends': 'html',
      \   'aliases': {
      \     'div': 'view',
      \     'span': 'text',
      \   },
      \  'default_attributes': {
      \     'block': [{'wx:for-items': '{{list}}','wx:for-item': '{{item}}'}],
      \     'navigator': [{'url': '', 'redirect': 'false'}],
      \     'scroll-view': [{'bindscroll': ''}],
      \     'swiper': [{'autoplay': 'false', 'current': '0'}],
      \     'icon': [{'type': 'success', 'size': '23'}],
      \     'progress': [{'precent': '0'}],
      \     'button': [{'size': 'default'}],
      \     'checkbox-group': [{'bindchange': ''}],
      \     'checkbox': [{'value': '', 'checked': ''}],
      \     'form': [{'bindsubmit': ''}],
      \     'input': [{'type': 'text'}],
      \     'label': [{'for': ''}],
      \     'picker': [{'bindchange': ''}],
      \     'radio-group': [{'bindchange': ''}],
      \     'radio': [{'checked': ''}],
      \     'switch': [{'checked': ''}],
      \     'slider': [{'value': ''}],
      \     'action-sheet': [{'bindchange': ''}],
      \     'modal': [{'title': ''}],
      \     'loading': [{'bindchange': ''}],
      \     'toast': [{'duration': '1500'}],
      \     'audio': [{'src': ''}],
      \     'video': [{'src': ''}],
      \     'image': [{'src': '', 'mode': 'scaleToFill'}],
      \   }
      \ },
      \}
    ```
## 语法检查相关

* javascript 推荐使用 [eslint](http://eslint.org/), 然后在 `.eslintrc` 中加入

    ``` json
    "globals": {
      "App": true,
      "Page": true,
      "wx": true
    },
    ```
  避免小程序变量的未定义错误。

* wxss 推荐使用 [stylelint](https://github.com/stylelint/stylelint),
针对 wxss 的[参考配置](https://gist.github.com/chemzqm/7fc6144d9953f9cfa71bd18fdfcee5b6), 安装本插件后可添加配置： `let g:neomake_wxss_enabled_makers = ['stylelint']` 启用 neomake 的 wxss 的代码检测。

* wxml 推荐使用 [tidy-html5](https://github.com/htacg/tidy-html5), 可使用命令 `brew install tidy-html5` 进行安装, 安装本插件后添加配置 `let g:neomake_wxml_enabled_makers = ['tidy']` 启用 neomake 的 wxml 代码检测。

## TODO

* omnicomplete 支持
* 文档跳转支持
* 异步接收 console 消息
* 编辑同步 AppData

## LICENSE
Copyright 2016 chemzqm@gmail.com

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the "Software"),
to deal in the Software without restriction, including without limitation
the rights to use, copy, modify, merge, publish, distribute, sublicense,
and/or sell copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included
in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
