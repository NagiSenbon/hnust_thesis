[![Actions Status](https://github.com/tuna/thuthesis/workflows/Test/badge.svg)](https://github.com/tuna/thuthesis/actions)
[![GitHub issues](https://img.shields.io/github/issues/NagiSenbon/hnust_thesis)](https://github.com/NagiSenbon/hnust_thesis/issues)
[![GitHub commits](https://img.shields.io/github/commits-since/tuna/thuthesis/latest)](https://https://github.com/NagiSenbon/hnust_thesis/commits/master)
[![GitHub license](https://img.shields.io/github/license/NagiSenbon/hnust_thesis)](https://github.com/NagiSenbon/hnust_thesis/blob/master/LICENSE)


# HNUST Thesis

此宏包基于 [ThuThesis](https://github.com/tuna/thuthesis)，并根据 [毕业设计（论文）要求与撰写规范（本部  理工类）](https://github.com/NagiSenbon/hnust_thesis/blob/master/scan/%E6%AF%95%E4%B8%9A%E8%AE%BE%E8%AE%A1%EF%BC%88%E8%AE%BA%E6%96%87%EF%BC%89%E8%A6%81%E6%B1%82%E4%B8%8E%E6%92%B0%E5%86%99%E8%A7%84%E8%8C%83%EF%BC%88%E6%9C%AC%E9%83%A8%20%20%E7%90%86%E5%B7%A5%E7%B1%BB%EF%BC%89.pdf) 进行格式调整。旨在建立一个简单易用的湖南科技大学学位论文 LaTeX 模板，帮助同学们免于word排版的困扰。

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
  * [GitHub Releases](https://github.com/NagiSenbon/hnust_thesis/releases)：最新版的及时发布途径。
  * [Overleaf](https://www.overleaf.com/latex/templates/thuthesis-tsinghua-university-thesis-latex-template/wddqnwbyhtnk)：Overleaf 的模板（更新较慢）。
* 开发版：[GitHub](https://github.com/NagiSenbon/hnust_thesis)

## 更新日志

每个版本的详细更新日志，请见 [CHANGELOG.md](./CHANGELOG.md)。使用文档中也包含了这一内容。

## 升级

### 手动更新

#### 发布版

下载发布版的的 zip 包，使用其中的 `thuthesis.cls` 等文件覆盖原有的即可，无须额外操作。


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
* `make doc`       生成模板使用说明书 thuthesis.pdf；
* `make clean`     删除示例文件的中间文件（不含 thuthesis-example.pdf）；
* `make cleanall`  删除示例文件的中间文件和 thuthesis-example.pdf；
* `make distclean` 删除示例文件和模板的所有中间文件和 PDF。

---

# Todo

- [ ] 封面、任务书、评语、答辩记录等 Latex 化
- [ ] 更详尽的格式调整
- [ ] hnust 化
- [ ] 硕士生及博士生的论文格式
