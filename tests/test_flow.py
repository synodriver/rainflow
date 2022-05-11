"""
Copyright (c) 2008-2021 synodriver <synodriver@gmail.com>
"""
from unittest import TestCase

import numpy as np
from matplotlib import pyplot as plt

from rainflow import path


class TestRain(TestCase):
    def test_flow(self):
        spec = np.array([500, -100, 300, -400, 400, -200, 100, -300, 0, -200, 500], float)
        plt.plot(spec)

        ret = path(spec)
        self.assertEqual(ret[0], [0, 1, 3, 4, 10])
        plt.plot([0, 1, 3, 4, 10], spec[[0, 1, 3, 4, 10]])
        plt.show()
        self.assertEqual(ret[1], [[-100, 300, -100], [400, -200, 100, -300, 0, -200, 400]])

    def test_subflow(self):
        spec = np.array([-100, 300, -100], float)
        ret = path(spec)
        self.assertEqual(ret[0], [0, 1, 2])
        self.assertEqual(ret[1], [])

    def test_sub2(self):
        spec = np.array([400, -200, 100, -300, 0, -200, 400], float)
        ret = path(spec)
        self.assertEqual(ret[0], [0, 1, 3, 4, 6])
        self.assertEqual(ret[1], [[-200, 100, -200], [0, -200, 0]])

    def test_sub3(self):
        spec = np.array([400.5, -200, 100, -300, 0, -200.5, 400.5], float)
        ret = path(spec)
        self.assertEqual(ret[0], [0, 1, 3, 4, 6])
        self.assertEqual(ret[1], [[-200, 100, -200], [0, -200.5, 0]])
