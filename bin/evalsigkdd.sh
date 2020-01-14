dataset_name=beta_music
python -W ignore evalall.py \
  ../runs/${dataset_name}/ \
  ../data/${dataset_name}/test/ratings.txt \
  evalres/beta_music.tsv
exit

dataset_name=beta_coat
python -W ignore evalall.py \
  ../runs/${dataset_name}/ \
  ../data/${dataset_name}/test/ratings.txt \
  evalres/beta_coat.tsv
exit
