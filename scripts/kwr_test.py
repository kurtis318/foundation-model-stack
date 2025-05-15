#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Copyright IBM Corp.
# SPDX-License-Identifier: Apache-2.0


"""
Test loading module like inference.py
"""


# pylint: disable=protected-access,unused-argument,missing-class-docstring
# pylint: disable=missing-function-docstring, line-too-long,invalid-name
# pylint: disable=unused-import,too-few-public-methods
# ruff: noqa: F401,F841


import argparse
import itertools
import os
import random

import numpy as np
import torch
import torch._inductor.config
from torch import distributed as dist

from fms.models import get_model
from fms.utils import generation, tokenizers
from fms.utils.generation import generate, pad_input_ids
from fms.models.bamba import _architecture_name
from typing import Any, Dict


ARCH="architecture"
VARI="variant"
MODP="model_path"
DEVT="device_type"
MODS="model_source"
DISS="distributed_strategy"
GROP="group"
FUSW="fused_weights"


class MyClassLoader():
    """Just a class that loads a model from fms
    """

    def __init__(self) -> None:
        """One and only constructor for this class.
        """

    def load_model(self,
                   parm_dict:Dict[str, Any]) -> None:
        model = get_model(
        parm_dict[ARCH],
        parm_dict[VARI],
        model_path=parm_dict[MODP],
        device_type=parm_dict[DEVT],
        source=parm_dict[MODS],
        distributed_strategy=parm_dict[DISS],
        group=parm_dict[GROP],
        fused_weights=not parm_dict[FUSW],
        )


def main() -> None:
    """Where all the action takes place
    """
    print("Just testing")


if __name__ == "__main__":
    main()
