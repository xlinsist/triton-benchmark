import hidet
import pytest
import torch
import numpy as np

hidet.option.save_lower_ir()


def test_profile_config():
    a = hidet.randn([512, 512], device='cpu')
    b = hidet.randn([512, 512], device='cpu')
    hidet.option.search_space(0)
    hidet.option.bench_config(1, 1, 1)
    c = hidet.ops.matmul_x86(a, b)
    print(c)
    hidet.option.search_space(0)

test_profile_config()





# import numpy as np
# import pytest
# import torch

# import hidet
# from hidet import ops
# from hidet.testing import check_binary, check_binary_dynamic, check_torch_binary, check_torch_binary_with_inputs


# # @pytest.mark.skip(reason="when running matmul_x86 multiple times, it will produce wrong result. need fix.")
# @pytest.mark.parametrize("a_shape, b_shape", [[[333, 444], [444, 555]], [[133, 1], [1, 177]]])
# def test_matmul_x86(a_shape, b_shape):
#     # TODO: Doesn't support broadcasting yet; need to add it later?

    
#     hidet.option.cache_dir("./debug_matmul")
#     hidet.option.search_space(2)
#     hidet.option.debug_cache_tuning()
#     hidet.option.save_lower_ir(True)

#     check_binary(
#         a_shape,
#         b_shape,
#         lambda x, y: np.matmul(x, y),
#         lambda x, y: ops.matmul_x86(x, y) - ops.matmul_x86(x, y) + ops.matmul_x86(x, y),
#         dtype="float32",
#         atol=1e-4,
#         rtol=1e-4,
#         device="cpu",
#     )
