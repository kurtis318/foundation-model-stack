import torch
from fms.models import get_model
from fms.utils import generation, tokenizers
from fms.utils.generation import generate, pad_input_ids
import pprint
from pycony import * 

from transformers import AutoModelForCausalLM, AutoTokenizer
import torch

MODEL_PATH="/mnt/aiu-models-en-shared/models/hf/qwen/qwen3-1.7B"

model = get_model(
    architecture='hf_pretrained',
    variant=None,
    model_path=MODEL_PATH,
    device_type="cpu",
    # data_type=torch.float16,
    data_type=torch.bfloat16,
    source=None,
    distributed_strategy=None,
    group=None,
    linear_config={'linear_type': 'torch_linear'},
    fused_weights=False,
)
