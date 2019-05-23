for ubs_ratio in 0.01 0.05 0.1 0.5; do
  dataset_name=coat-vd_${ubs_ratio}
  ./runall.sh ${dataset_name}
  dataset_name=coat+vd_${ubs_ratio}
  ./runall.sh ${dataset_name}
done
