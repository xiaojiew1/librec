dataset_name=$1
dataset_name_list=(amazon coat movie song amason mcoat)
if ! [[ ${dataset_name_list[*]} =~ $dataset_name ]]
then
  echo 'unknown dataset' ${dataset_name}
  exit
fi
rm -rf ../runs/${dataset_name}

input_path=${dataset_name}/train
testset_path=${dataset_name}/test

model_splitter=testset
eval_classes=mae,mse

recommender_class_list='biasedmf pmf'
iterator_maximum=200

iterator_learnrate_list='0.005 0.01'
learnrate_decay_list='0.9 1.0'

user_regularization_list='0.005 0.01 0.05'
item_regularization_list='0.005 0.01 0.05'
bias_regularization_list='0.005 0.01 0.05'

factor_number_list='20 40 80 160 320'

for recommender_class in ${recommender_class_list}; do
  for iterator_learnrate in ${iterator_learnrate_list}; do
    for learnrate_decay in ${learnrate_decay_list}; do
      for user_regularization in ${user_regularization_list}; do
        for item_regularization in ${item_regularization_list}; do
          for bias_regularization in ${bias_regularization_list}; do
            for factor_number in ${factor_number_list}; do

param=${user_regularization}_${item_regularization}_${bias_regularization}
param=${iterator_learnrate}_${learnrate_decay}_${param}
param=${param}_${factor_number}
output_path=../runs/${dataset_name}/${recommender_class}_${param}
# echo ${output_path}
if [ -f ${output_path} ]
then
  echo 'find' ${output_path}
  continue
fi
echo 'not find' ${output_path}
./librec rec -exec \
  -D data.input.path=${input_path} \
  -D data.model.splitter=${model_splitter} \
  -D data.testset.path=${testset_path} \
  -D data.output.path=${output_path} \
  -D rec.eval.classes=${eval_classes} \
  -D rec.recommender.class=${recommender_class} \
  -D rec.iterator.maximum=${iterator_maximum} \
  -D rec.learnrate.decay=${learnrate_decay} \
  -D rec.user.regularization=${user_regularization} \
  -D rec.item.regularization=${item_regularization} \
  -D rec.bias.regularization=${bias_regularization} \
  -D rec.factor.number=${factor_number}
# exit

            done
          done
        done
      done
    done
  done
done
exit

