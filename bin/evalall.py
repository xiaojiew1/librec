from os import path
from sklearn import metrics
import argparse
import os

def load_data_set(rating_file, delimiter=None):
  data_set = []
  with open(rating_file) as fin:
    for line in fin.readlines():
      if delimiter == None:
        fields = line.strip().split()
      else:
        fields = line.strip().split(delimiter)
      user = int(fields[0])
      item = int(fields[1])
      rating = float(fields[2])
      data_set.append((user, item, rating))
  data_set = sorted(data_set, key=lambda t: (t[0], t[1]))
  return data_set

def eval_once(pred_file, test_file, out_file):
  pred_set = load_data_set(pred_file, delimiter=",")
  test_set = load_data_set(test_file)
  assert len(pred_set) == len(test_set)
  rating_pred = dict()
  rating_test = dict()
  ratings = set()
  for pred_triple, test_triple in zip(pred_set, test_set):
    assert pred_triple[0] == test_triple[0]
    assert pred_triple[1] == test_triple[1]
    rating = int(test_triple[2])
    if rating not in rating_pred:
      rating_pred[rating] = []
    rating_pred[rating].append(pred_triple[2])
    if rating not in rating_test:
      rating_test[rating] = []
    rating_test[rating].append(test_triple[2])
    ratings.add(rating)
  pred_ratings = [pred_triple[2] for pred_triple in pred_set]
  test_ratings = [test_triple[2] for test_triple in test_set]
  mae_list = []
  mse_list = []
  mae = metrics.mean_absolute_error(pred_ratings, test_ratings)
  mse = metrics.mean_squared_error(pred_ratings, test_ratings)
  mae_list.append(mae)
  mse_list.append(mse)
  print("%s\t%.4f\t%.4f" % (path.basename(pred_file), mae, mse))
  ae = 0
  se = 0
  n_test = 0
  for rating in sorted(ratings):
    pred_ratings = rating_pred[rating]
    test_ratings = rating_test[rating]
    mae = metrics.mean_absolute_error(pred_ratings, test_ratings)
    mse = metrics.mean_squared_error(pred_ratings, test_ratings)
    mae_list.append(mae)
    mse_list.append(mse)
    print("\t%d\t%.4f\t%.4f" % (rating, mae, mse))
    n_test += len(test_ratings)
    ae += len(test_ratings) * mae
    se += len(test_ratings) * mse
  mae = ae / n_test
  mse = se / n_test
  print("\t%s\t%.4f\t%.4f" % ("avg", mae, mse))
  with open(out_file, "a") as fout:
    fout.write(path.basename(pred_file))
    for mae in mae_list:
      fout.write("\t%.4f" % mae)
    for mse in mse_list:
      fout.write("\t%.4f" % mse)
    fout.write("\n")

def main():
  parser = argparse.ArgumentParser()
  parser.add_argument('runs_dir', type=str)
  parser.add_argument('test_file', type=str)
  parser.add_argument('out_file', type=str)
  args = parser.parse_args()
  runs_dir = args.runs_dir
  out_file = args.out_file
  if path.exists(out_file):
    os.remove(out_file)
  for pred_file in os.listdir(runs_dir):
    pred_file = path.join(runs_dir, pred_file)
    eval_once(pred_file, args.test_file, out_file)

if __name__ == '__main__':
  main()