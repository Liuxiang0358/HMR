#!/bin/bash
# Copyright 2022 Huawei Technologies Co., Ltd
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ============================================================================

if [ $# != 1 ] && [ $# != 2 ]
then
    echo "bash run_eval.sh  [DATASET_PATH] [PREevalED_CKPT_PATH] "
exit 1
fi


get_real_path(){
  if [ "${1:0:1}" == "/" ]; then
    echo "$1"
  else
    echo "$(realpath -m $PWD/$1)"
  fi
}
ulimit -u unlimited
PATH1=$(get_real_path $1)
PATH2=$(get_real_path $2)

if [ -d "eval" ];
then
    rm -rf ./eval
fi
mkdir ./eval
cp -r ./*.py ./eval
cp -r ./*.yaml ./eval
cp -r ./src ./eval
cd ./eval ||exit

python eval.py --data_path=$PATH1 --checkpoint_file_path=$PATH2 > eval.log 2>&1 &