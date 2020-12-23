利用数组

```
created() {
    let exportParam = [...this.queryParam]
    // 删除数组中的第一位
    data.splice(0,1)
}
```

JSON

```
// 保存上一次查询条件，作为导出条件
this.viewModel = this.queryParam;
this.exportParam = JSON.parse(JSON.stringify(this.viewModel));

```

Object.assign

```
const targetParam = {};
Object.assign(targetParam, this.queryParam);
this.exportParam = targetParam;
```

