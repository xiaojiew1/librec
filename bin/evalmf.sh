if [ "$#" -ne 1 ]
then
  echo "usage: $0 amazon|coat|ml-1m|song" >&2
  exit 1
fi

dataset_name=$1
dataset_name_list=(amazon coat ml-1m song)
if ! [[ ${dataset_name_list[*]} =~ $dataset_name ]]
then
  echo 'unknown dataset' ${dataset_name}
  exit 1
fi

python -W ignore evalall.py \
  ../runs/${dataset_name}/ \
  ../data/${dataset_name}/test/ratings_0.txt
