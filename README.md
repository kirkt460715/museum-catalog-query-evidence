# 馆校联展目录的检索资料

目录编辑交接候选配置、展示日志与独立评阅，作品号为合成编号。

## 资料来源与口径

以下均为本地合成记录。CSV 为 UTF-8，空白字段表示来源未提供值。时间均按北京时间，日期和分钟采用原资料的业务口径。

候选排序由目录方随词表配置交送。每一列表使用自己的查询编号、配置、目录版本和观察日。位置从 1 起，前三位为首屏。对受保护范围按对应查询组单独判断。

### `资料/queries.csv`

intent_hint 是独立招募的查询意向类别，查询词相同且场馆或意向不同可有不同 query。scope 为馆内、校或联合目录。

主键 `query`。

### `资料/catalog.csv`

withdraws 表示首个不再可检索的业务日期，库存版次通过候选列表另行标注。

主键 `item`。

### `资料/aliases.csv`

shared 已告知合作校。联合 scope 可影响下属馆或学校的同语言查询。

主键 `rule`。

### `资料/configurations.csv`

候选方案按完整规则集合登记。catalog-2 已纳入 10 月 25 日撤展。generated 为提交日。

主键 `config`。

### `资料/ranks.csv`

完整候选配置生成的前六项，缺整组记录表示尚未提交结果。

主键 `config`、`query`、`position`。

### `资料/impressions.csv`

session 是同次查询；position 为显示位次，observation_chance 来自同期随机换位测得的可见机会，不代表相关性。点击为 0 或 1。

主键 `session`、`position`。

### `资料/observation_blocks.csv`

时段档由联展方随访问记录提供。period 同号对应同期观察。fresh 是首次访问目录，returning 是已访问者。

主键 `session`。

### `资料/judgements.csv`

grade 为 0–3，三分完全相关。允许不同评阅人有分歧，重复派审表不是独立意见。withdrawn 仅撤销指定评阅人同一对象同版本的早期意见。

主键 `entry`。

### `资料/guards.csv`

保护规则定义同组可比较的最少查询、评阅深度、首屏可比较结果比例，以及主口径归一后的最大允许损失。

主键 `scope`、`language`。

### `资料/actions.csv`

active 表示当前保留的默认目录配置，shared 表示已告知有关学校的作用范围，proposed 表示待核准。

主键 `notice`。

### `资料/inheritance.csv`

馆内范围始终继承联合词表中适用于本馆的部分。fallback 是单独退回本馆的配置，仍须同现行联合词表一并核对。

主键 `scope`、`at`。

### `资料/assessment_availability.csv`

一次独立评阅占四分钟，需与词表原编辑独立。收到候选生成时间晚于期限的不能提前派出人工评阅。

主键 `examiner`、`language`。

## 读取交接资料

使用 Python 3.11。下面的入口读取本地交接表并检查表头、主键和已知引用。单元测试覆盖资料读取和已记录的基础契约。

```sh
python3 source_check.py
python3 -m unittest discover -s tests -v
```

统计与数值计算所用依赖锁定在 `requirements.txt`，预装环境使用同一清单。本机可在 Python 3.11 的虚拟环境内运行 `python3 -m pip install -r requirements.txt`。
