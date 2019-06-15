evalres_dir=evalres
if [ ! -d ${evalres_dir} ]; then
  mkdir ${evalres_dir}
fi

dataset_name=movie_excl_0.05
./evalall.sh ${dataset_name} > ${evalres_dir}/${dataset_name}.csv
dataset_name=movie_incl_0.05
./evalall.sh ${dataset_name} > ${evalres_dir}/${dataset_name}.csv
exit

dataset_name=music_excl_0.05
./evalall.sh ${dataset_name} > ${evalres_dir}/${dataset_name}.csv
dataset_name=music_incl_0.05
./evalall.sh ${dataset_name} > ${evalres_dir}/${dataset_name}.csv
exit

dataset_name=coat_excl_0.05
./evalall.sh ${dataset_name} > ${evalres_dir}/${dataset_name}.csv
dataset_name=coat_incl_0.05
./evalall.sh ${dataset_name} > ${evalres_dir}/${dataset_name}.csv
exit
