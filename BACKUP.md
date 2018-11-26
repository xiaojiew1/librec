python -W ignore evalall.py \
  ../runs/amazon/ \
  ../data/amazon/test/ratings_0.txt

python -W ignore evalall.py \
  ../runs/coat/ \
  ../data/coat/test/ratings_0.txt

python -W ignore evalall.py \
  ../runs/ml-1m/ \
  ../data/ml-1m/test/ratings_0.txt

python -W ignore evalall.py \
  ../runs/song/ \
  ../data/song/test/ratings_0.txt

### bin/librec
# xiaojie
export CLASSPATH=${LIBREC_HOME}/core/target/classes:${LIBREC_HOME}/core/target/test-classes:${CLASSPATH}


### core/src/main/java/net/librec/tool/driver/RecDriver.java
// xiaojie
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
    // xiaojie
    final static Log LOG = LogFactory.getLog(RecDriver.class);
        // xiaojie
        LOG.info("We have overridden the default core classpath in librec.");


### core/src/main/java/net/librec/job/RecommenderJob.java
            // xiaojie
            outputPath = conf.get("data.output.path");


### core/src/main/java/net/librec/data/splitter/GivenTestSetDataSplitter.java
        // xiaojie
//        // remove test elements from trainMatrix
//        for (MatrixEntry me : testMatrix) {
//            int rowIdx = me.row();
//            int colIdx = me.column();
//            trainMatrix.set(rowIdx, colIdx, 0.0);
//        }
//        trainMatrix.reshape();

### if no save result, use below
### core/src/main/java/net/librec/job/RecommenderJob.java
// xiaojie
import net.librec.recommender.item.ContextKeyValueEntry;
import net.librec.recommender.item.RecommendedList;
import com.google.common.collect.BiMap;
import java.util.Iterator;
        // xiaojie
        StringBuilder sb = new StringBuilder();
        DataSet testDataset =  dataModel.getTestDataSet();
        BiMap<Integer, String> userIds = dataModel.getUserMappingData().inverse();
        BiMap<Integer, String> itemIds = dataModel.getItemMappingData().inverse();
        RecommendedList recommendedList = recommender.recommendRating(testDataset);
        Iterator<ContextKeyValueEntry> recommendedEntryIter = recommendedList.iterator();
        while (recommendedEntryIter.hasNext()) {
        	ContextKeyValueEntry recommendedEntry = recommendedEntryIter.next();
        	int userIdx = recommendedEntry.getContextIdx();
        	int itemIdx = recommendedEntry.getKey();
        	double rating = recommendedEntry.getValue();
        	String user = userIds.get(userIdx);
        	String item = itemIds.get(itemIdx);
//        	System.out.printf("%s %s %.16f\n", user, item, rating);
        	sb.append(user).append(" ").append(item).append(" ").append(rating).append("\n");
        }
        String resultData = sb.toString();
        String outputPath = conf.get("data.output.path");
        LOG.info("Result path is " + outputPath);
        try {
            FileUtil.writeString(outputPath, resultData);
        } catch (Exception e) {
            e.printStackTrace();
        }
