[![Actions Status](https://github.com/tuna/thuthesis/workflows/Test/badge.svg)](https://github.com/tuna/thuthesis/actions)
[![GitHub issues](https://img.shields.io/github/issues/NagiSenbon/hnust_thesis)](https://github.com/NagiSenbon/hnust_thesis/issues)
[![GitHub commits](https://img.shields.io/github/commits-since/tuna/thuthesis/latest)](https://https://github.com/NagiSenbon/hnust_thesis/commits/master)
[![CTAN](https://img.shields.io/ctan/v/thuthesis)](https://www.ctan.org/pkg/thuthesis)
[![GitHub license](https://img.shields.io/github/license/NagiSenbon/hnust_thesis)](https://github.com/NagiSenbon/hnust_thesis/blob/master/LICENSE)


# HNUST Thesis

此宏包基于 [ThuThesis](https://github.com/tuna/thuthesis)，旨在建立一个简单易用的湖南科技大学学位论文 LaTeX 模板，帮助同学们免于word排版的困扰。

**由于模板升级频繁，在开始使用和提问前，请确保您已经认真完整地阅读了使用说明文档和示例代码。**

**由于模板升级频繁，在开始使用和提问前，请确保您已经认真完整地阅读了使用说明文档和示例代码。**

**由于模板升级频繁，在开始使用和提问前，请确保您已经认真完整地阅读了使用说明文档和示例代码。**

## 下载

推荐下载**发布版**模板，里面包括具体使用说明以及示例文档：

* 模板使用说明 (thuthesis.pdf)
* 示例文档 (thuthesis-example.pdf)

开发版中不提供预生成的 `cls` 文件和文档，仅包含源码。其仅供开发者与需要尚未发布的功能的有经验的 TeX 用户使用，不提供任何保证。

下载途径：

* 发布版：
  * [GitHub Releases](https://github.com/tuna/thuthesis/releases)：最新版的及时发布途径。
  * [Overleaf](https://www.overleaf.com/latex/templates/thuthesis-tsinghua-university-thesis-latex-template/wddqnwbyhtnk)：Overleaf 的模板（更新较慢）。
* 开发版：[GitHub](https://github.com/tuna/thuthesis)

## 更新日志

每个版本的详细更新日志，请见 [CHANGELOG.md](./CHANGELOG.md)。使用文档中也包含了这一内容。

## 升级

### 手动更新

#### 发布版

下载发布版的的 zip 包，使用其中的 `thuthesis.cls` 等文件覆盖原有的即可，无须额外操作。

#### 开发板

从 GitHub clone 项目源码或者下载源码 zip 包，执行命令（Windows 用户在文件夹空白处按 `Shift + 鼠标右键`，点击“在此处打开命令行窗口”）：

```shell
xetex thuthesis.ins
```

即可得到 `thuthesis.cls` 等模板文件。

## 提问
按推荐顺序排序：

* 先到 [FAQ](https://github.com/tuna/thuthesis/wiki/FAQ) 看看常见问题
* [GitHub Issues](https://github.com/tuna/thuthesis/issues)

## Makefile的用法

```shell
make [{all|thesis|spine|doc|clean|cleanall|distclean}]
```

### 目标
* `make thesis`    生成论文 thuthesis-example.pdf；
* `make spine`     生成书脊 spine.pdf；
* `make doc`       生成模板使用说明书 thuthesis.pdf；
* `make all`       生成论文和书脊，相当于 `make thesis && make spine`；
* `make clean`     删除示例文件的中间文件（不含 thuthesis-example.pdf）；
* `make cleanall`  删除示例文件的中间文件和 thuthesis-example.pdf；
* `make distclean` 删除示例文件和模板的所有中间文件和 PDF。

---
