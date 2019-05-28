if [ "$#" -ne 1 ]
then
  echo "usage: $0 dataset_name" >&2
  exit 1
fi

dataset_name=$1
dataset_dir=../data/${dataset_name}
if [ ! -d ${dataset_dir} ]; then
  echo 'Cannot find the dataset'
  exit
fi

python -W ignore evalall.py \
  ../runs/${dataset_name} \
  ${dataset_dir}/test/ratings.txt
