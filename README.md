# vercel-hugo-build-sh

新版本 Hugo 建议通过 go mod 安装主题，但是 vercel 为工程分配的运行环境并不可控，手动设置 Install Command 比较麻烦。因此这里提供一种兼容性较强的方案，自动在部署阶段安装 go 环境并完成编译部署。

## 使用教程

1. 将**该脚本**以及 **Linux amd64 体系结构的 [hugo](https://github.com/gohugoio/hugo) 可执行文件**复制到 hugo 工程根目录：
   ![image](https://github.com/LoongmaSpirit/vercel-hugo-build-sh/assets/162437080/b8fbed9e-2e86-48c4-9039-f555ad720087)
2. 修改 vercel.json 文件，增加以下内容：
   ```json
   {
      "$schema": "https://openapi.vercel.sh/vercel.json",
      "version": 2,
      "regions": [
          "hkg1"
      ],
      "buildCommand": "chmod +x ./build.sh; ./build.sh",
    ...
   }
   ```
3. 提交触发编译即可！

## 注意事项

该脚本通过工程自带的 hogo 可执行文件进行编译：

```sh
chmod +x ./hugo
./hugo --gc
```

这么做是为了方便控制 hugo 版本号，如果您的主题确认支持最新版 hugo，可以修改为 `hugo --gc`，不过不建议这么做！因为 hugo 经常进行不兼容更新！！
