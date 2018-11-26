from os import path
from sklearn import metrics
import argparse
import os

def load_rating(rating_file, delimiter=None):
  ratings = []
  with open(rating_file) as fin:
    for line in fin.readlines():
      if delimiter == None:
        fields = line.strip().split()
      else:
        fields = line.strip().split(delimiter)
      user = int(fields[0])
      item = int(fields[1])
      rating = float(fields[2])
      ratings.append((user, item, rating))
  ratings = sorted(ratings, key=lambda r: (r[0], r[1]))
  return ratings

def eval_run(run_file, test_file):
  run_ratings = load_rating(run_file, delimiter=',')
  test_ratings = load_rating(test_file)
  for run_rating, test_rating in zip(run_ratings, test_ratings):
    assert run_rating[0] == test_rating[0]
    assert run_rating[1] == test_rating[1]
  run_ratings = [run_rating[-1] for run_rating in run_ratings]
  test_ratings = [test_rating[-1] for test_rating in test_ratings]
  mae = metrics.mean_absolute_error(test_ratings, run_ratings)
  mse = metrics.mean_squared_error(test_ratings, run_ratings)
  # print('run=%s mae=%.4f mse=%.4f' % (run_file, mae, mse))
  print('%s\t%.4f\t%.4f' % (path.basename(run_file), mae, mse))

def main():
  parser = argparse.ArgumentParser()
  parser.add_argument('runs_dir', type=str)
  parser.add_argument('test_file', type=str)
  args = parser.parse_args()
  runs_dir = args.runs_dir
  test_file = args.test_file
  for run_file in os.listdir(runs_dir):
    run_file = path.join(runs_dir, run_file)
    eval_run(run_file, test_file)

if __name__ == '__main__':
  main()