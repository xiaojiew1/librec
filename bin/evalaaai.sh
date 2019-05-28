result_dir=result
rm -rf ${result_dir}
mkdir ${result_dir}

for ubs_ratio in 0.01 0.05 0.1 0.5; do
  dataset_name=coat_excl_${ubs_ratio}
  ./evalall.sh ${dataset_name} > result/${dataset_name}.csv
  dataset_name=coat_incl_${ubs_ratio}
  ./evalall.sh ${dataset_name} > result/${dataset_name}.csv
done
