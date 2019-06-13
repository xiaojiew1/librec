for ubs_ratio in 0.01 0.05 0.1 0.5; do
  dataset_name=music_excl_${ubs_ratio}
  ./runall.sh ${dataset_name}
  dataset_name=music_incl_${ubs_ratio}
  ./runall.sh ${dataset_name}
done
exit

for ubs_ratio in 0.01 0.05 0.1 0.5; do
  dataset_name=coat_excl_${ubs_ratio}
  ./runall.sh ${dataset_name}
  dataset_name=coat_incl_${ubs_ratio}
  ./runall.sh ${dataset_name}
done
exit
