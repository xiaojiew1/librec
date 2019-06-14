dataset_name=$1
dataset_dir=../data/${dataset_name}
if [ ! -d ${dataset_dir} ]; then
  echo 'Cannot find the dataset'
  exit
fi
rm -rf ../runs/${dataset_name}

input_path=${dataset_name}/train
testset_path=${dataset_name}/test

model_splitter=testset
eval_classes=mae,mse

iterator_maximum=200
recommender_class_list='biasedmf pmf'
iterator_learnrate_list='0.001 0.005 0.01 0.05' # '0.001'
regularization_list='0.001 0.005 0.01 0.05 0.1' # '0.001'
factor_number_list='20 40 80 160 320' # '20'

for recommender_class in ${recommender_class_list}; do
  for factor_number in ${factor_number_list}; do
    for regularization in ${regularization_list}; do
      for iterator_learnrate in ${iterator_learnrate_list}; do

param=${factor_number}_${iterator_learnrate}_${regularization}
output_path=../runs/${dataset_name}/${recommender_class}_${param}
# echo ${output_path}
if [ -f ${output_path} ]
then
  echo 'Find' ${output_path}
  continue
fi
echo 'Cannot find' ${output_path}
./librec rec -exec \
  -D data.input.path=${input_path} \
  -D data.model.splitter=${model_splitter} \
  -D data.testset.path=${testset_path} \
  -D data.output.path=${output_path} \
  -D rec.eval.classes=${eval_classes} \
  -D rec.recommender.class=${recommender_class} \
  -D rec.iterator.maximum=${iterator_maximum} \
  -D rec.iterator.learnrate=${iterator_learnrate} \
  -D rec.user.regularization=${regularization} \
  -D rec.item.regularization=${regularization} \
  -D rec.bias.regularization=${regularization} \
  -D rec.factor.number=${factor_number}
# exit

      done
    done
  done
done
exit

