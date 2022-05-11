# 载荷谱分析 -- 雨流计数法

```python
from typing import Tuple, List
import numpy


def path(spectrum: numpy.ndarray) -> Tuple[List[int], List[List[float]]]: ...
```

- 输入载荷谱（支持缓冲区协议的一维C连续double数组），返回雨流路径（索引）， 下一次要继续分析的子谱（可能不止一个）