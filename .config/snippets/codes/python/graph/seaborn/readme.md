<!-- FileName: readme
 Author: 8ucchiman
 CreatedDate: 2023-02-15 10:49:54 +0900
 LastModified: 2023-02-15 11:16:10 +0900
 Reference: 8ucchiman.jp
-->


# FacetGrid

```python
    import seaborn as sns
    import matplotlib.pyplot as plt

    tips = sns.load_dataset("tips")
    grid = sns.FacetGrid(tips, col="time", row="sex")      # tips: pd.DataFrame
    grid.map(sns.scatterplot, "total_bill", "tip")
    plt.show()
```
![example](https://seaborn.pydata.org/_images/FacetGrid_5_0.png)



```
```
