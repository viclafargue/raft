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
#include <raft_runtime/neighbors/ivf_pq.hpp>

namespace raft::runtime::neighbors::ivf_pq {

#define RAFT_INST_BUILD_EXTEND(T, IdxT)                                                            \
  auto build(raft::device_resources const& handle,                                                 \
             raft::device_matrix_view<const T, IdxT, row_major> dataset,                           \
             const raft::neighbors::ivf_pq::index_params& params)                                  \
  {                                                                                                \
    return raft::neighbors::ivf_pq::build<T, IdxT>(handle, dataset, params);                       \
  }                                                                                                \
  void build(raft::device_resources const& handle,                                                 \
             raft::neighbors::ivf_pq::index<IdxT>* idx,                                            \
             raft::device_matrix_view<const T, IdxT, row_major> dataset,                           \
             const raft::neighbors::ivf_pq::index_params& params)                                  \
  {                                                                                                \
    raft::neighbors::ivf_pq::build<T, IdxT>(handle, idx, dataset, params);                         \
  }                                                                                                \
  auto extend(raft::device_resources const& handle,                                                \
              const raft::neighbors::ivf_pq::index<IdxT>& orig_index,                              \
              raft::device_matrix_view<const T, IdxT, row_major> new_vectors,                      \
              std::optional<raft::device_matrix_view<const IdxT, IdxT, row_major>> new_indices)    \
  {                                                                                                \
    return raft::neighbors::ivf_pq::extend<T, IdxT>(handle, orig_index, new_vectors, new_indices); \
  }                                                                                                \
  void extend(raft::device_resources const& handle,                                                \
              raft::neighbors::ivf_pq::index<IdxT>* idx,                                           \
              raft::device_matrix_view<const T, IdxT, row_major> new_vectors,                      \
              std::optional<raft::device_matrix_view<const IdxT, IdxT, row_major>> new_indices)    \
  {                                                                                                \
    raft::neighbors::ivf_pq::extend<T, IdxT>(handle, idx, new_vectors, new_indices);               \
  }

RAFT_INST_BUILD_EXTEND(float, int64_t);
RAFT_INST_BUILD_EXTEND(int8_t, int64_t);
RAFT_INST_BUILD_EXTEND(uint8_t, int64_t);

#undef RAFT_INST_BUILD_EXTEND

}  // namespace raft::runtime::neighbors::ivf_pq
