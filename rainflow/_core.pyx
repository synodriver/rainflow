# cython: language_level=3
# cython: cdivision=True

# todo 返回的子谱用ndarray能不能提速？
cpdef inline tuple path(double[::1] spectrum):
    """def path(spectrum: numpy.ndarray) -> tuple
    
    :param spectrum: 载荷谱 一维连续数组
    :return: 本次雨流经过节点的索引 和产生的子雨流
    """
    cdef:
        int i, temp
        int current_index=1 # 当前雨滴到哪了
    # 雨流计数后 留下没有流经的地方 这里面可不是索引
    sub_spectrums = []  # type: list[list[float]]
    path = [0, 1]  # 以索引表示当前雨流的路径 必然经过0, 1
    while current_index!= <int>spectrum.shape[0]-1:   # 没落到底
        for i in range(current_index, <int>(spectrum.shape[0]-1)):
            if spectrum[i]<spectrum[current_index]<spectrum[i+1] or spectrum[i]>spectrum[current_index]>spectrum[i+1]:  # 下落的地方找到了
                current_sub_spectrum = []  # 路径跳跃了 必然有地方没有经过 这些节点将加入当前子谱
                for temp in range(current_index, i+1):
                    current_sub_spectrum.append(spectrum[temp])
                current_sub_spectrum.append(spectrum[current_index])  # 使子谱闭合
                sub_spectrums.append(current_sub_spectrum) # 多一个子谱

                path.append(i+1)
                current_index = i+1
                break
            if i == <int>(spectrum.shape[0]-2): # 没有下一层，只能原路折返
                current_index += 1
                path.append(current_index)

    return path, sub_spectrums
