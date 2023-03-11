/*
 * Copyright (c) 2022-2023, NVIDIA CORPORATION.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <raft/neighbors/ivf_pq.cuh>
#include <raft/neighbors/specializations.cuh>

namespace raft::neighbors::ivf_pq {

#define RAFT_MAKE_INSTANCE(T, IdxT)                                                        \
  template auto build<T, IdxT>(raft::device_resources const& handle,                       \
                               raft::device_matrix_view<const T, IdxT, row_major> dataset, \
                               const index_params& params)                                 \
    ->index<IdxT>;                                                                         \
  template void build<T, IdxT>(raft::device_resources const& handle,                       \
                               index<IdxT>* index,                                         \
                               raft::device_matrix_view<const T, IdxT, row_major> dataset, \
                               const index_params& params);

RAFT_MAKE_INSTANCE(float, int64_t);

#undef RAFT_MAKE_INSTANCE

}  // namespace raft::neighbors::ivf_pq
