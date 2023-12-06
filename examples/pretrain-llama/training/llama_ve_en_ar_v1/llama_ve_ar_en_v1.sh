
PRETRAINED_LLAMA_MODEL_PATH=$1
TOKENIZER_MODEL=$2
BIN_IDX_PATH=$3
DATA_CACHE=$4
CHECKPOINT_DIR=$5
TENSORBOARD_LOGS_PATH=$6

# DISTRIBUTED_ARGS=(
#     --nproc_per_node $GPUS_PER_NODE 
#     --nnodes $NUM_NODES 
#     --master_addr $MASTER_ADDR 
#     --master_port $MASTER_PORT
# )

GPT_MODEL_ARGS=(
    --seq-length 4096 
    --max-position-embeddings 4096 
    --tokenizer-type Llama2Tokenizer
    --exit-on-missing-checkpoint
    --use-checkpoint-args
    --untie-embeddings-and-output-weights
    --use-rotary-position-embeddings
    --normalization RMSNorm
    --no-position-embedding
    --no-masked-softmax-fusion
    --no-query-key-layer-scaling
)

LOGISTICS_ARGS=(
    --save $CHECKPOINT_DIR 
    --load $PRETRAINED_LLAMA_MODEL_PATH 
    --tokenizer-model $TOKENIZER_MODEL
    --split 9998,1,1 
    --log-interval 100
    --save-interval 10000 
    --eval-interval 1000 
    --eval-iters 50
    --tensorboard-dir $TENSORBOARD_LOGS_PATH 
    --tensorboard-log-interval 100
    --data-cache-path $DATA_CACHE
    --log-validation-ppl-to-tensorboard 
)

TRAINING_ARGS=(
    --no-initialization
    --no-load-optim
    --no-load-rng
    --micro-batch-size 1 
    --global-batch-size 1024
    --train-iters 250000
    --lr 0.000001 
    --lr-decay-style cosine 
    --weight-decay 0.1 
    --adam-beta1 0.9 
    --adam-beta2 0.95 
    --init-method-std 0.006 
    --clip-grad 1.0 
    --lr 1.0e-6 
    --min-lr 1.0e-6
    --lr-warmup-iters 10000
    --use-flash-attn
    --bf16
)
# --use-mcore-models

MODEL_PARALLEL_ARGS=(
	--tensor-model-parallel-size 2
    --pipeline-model-parallel-size 2
    --no-async-tensor-model-parallel-allreduce
)

DATA_PATH=(
    --data-path
    0.05399135177643786 $BIN_IDX_PATH/ar_books_split_00_text_document_dc\=74697_sc\=74697_tc\=7359767754
    0.047599218902527704 $BIN_IDX_PATH/ar_books_split_01_text_document_dc\=182478_sc\=182478_tc\=6488431663
    0.0038874998078634753 $BIN_IDX_PATH/ar_encyclopedias_split_00_text_document_dc\=1134657_sc\=1134657_tc\=529919974
    0.020471206101213894 $BIN_IDX_PATH/ar_news_split_00_text_document_dc\=13366967_sc\=13366967_tc\=5581016870
    0.022590970948977065 $BIN_IDX_PATH/ar_news_split_01_text_document_dc\=12454060_sc\=12454060_tc\=6158923385
    0.023880388219562995 $BIN_IDX_PATH/ar_news_split_02_text_document_dc\=8106915_sc\=8106915_tc\=6510454189
    0.02224889699561437 $BIN_IDX_PATH/ar_news_split_03_text_document_dc\=11173000_sc\=11173000_tc\=6065664566
    0.013952441392119508 $BIN_IDX_PATH/ar_news_split_04_text_document_dc\=10090583_sc\=10090583_tc\=3803821348
    0.006803070310018241 $BIN_IDX_PATH/ar_others_split_00_text_document_dc\=927554_sc\=927554_tc\=1391028818
    0.00397030185587864 $BIN_IDX_PATH/ar_transcribed_split_00_text_document_dc\=86178_sc\=86178_tc\=541207038
    0.007348558384279548 $BIN_IDX_PATH/ar_translated_En_wikipedia_split_translated_split_00_text_document_dc\=20745266_sc\=20745266_tc\=3005130336
    0.016459475894679318 $BIN_IDX_PATH/ar_web_arabicweb16_v2_split_00_text_document_dc\=5122708_sc\=5122708_tc\=6730962420
    0.0165995709642856 $BIN_IDX_PATH/ar_web_arabicweb16_v2_split_01_text_document_dc\=5575027_sc\=5575027_tc\=6788253105
    0.016631180604432163 $BIN_IDX_PATH/ar_web_arabicweb16_v2_split_02_text_document_dc\=5521485_sc\=5521485_tc\=6801179598
    0.016525039820963764 $BIN_IDX_PATH/ar_web_arabicweb16_v2_split_03_text_document_dc\=5408044_sc\=5408044_tc\=6757774229
    0.01656438553866799 $BIN_IDX_PATH/ar_web_arabicweb16_v2_split_04_text_document_dc\=5351784_sc\=5351784_tc\=6773864325
    0.016617658794391806 $BIN_IDX_PATH/ar_web_arabicweb16_v2_split_05_text_document_dc\=5170226_sc\=5170226_tc\=6795649969
    0.016528423662100514 $BIN_IDX_PATH/ar_web_arabicweb16_v2_split_06_text_document_dc\=5294345_sc\=5294345_tc\=6759158022
    0.016554128031878203 $BIN_IDX_PATH/ar_web_arabicweb16_v2_split_07_text_document_dc\=5443921_sc\=5443921_tc\=6769669605
    0.016540949757544374 $BIN_IDX_PATH/ar_web_arabicweb16_v2_split_08_text_document_dc\=5271931_sc\=5271931_tc\=6764280462
    0.0165748337059898 $BIN_IDX_PATH/ar_web_arabicweb16_v2_split_09_text_document_dc\=5273864_sc\=5273864_tc\=6778137014
    0.00645820778773341 $BIN_IDX_PATH/ar_web_arabicweb16_v2_split_10_text_document_dc\=1971786_sc\=1971786_tc\=2641029046
    0.015322207122491186 $BIN_IDX_PATH/ar_web_arabicweb22_split_00_text_document_dc\=84634264_sc\=84634264_tc\=6265886046
    0.01037247001407337 $BIN_IDX_PATH/ar_web_arabicweb22_split_01_text_document_dc\=27533033_sc\=27533033_tc\=4241733231
    0.01658006682150535 $BIN_IDX_PATH/ar_web_metadialog_split_00_text_document_dc\=6188667_sc\=6188667_tc\=6780277052
    0.016450932457103766 $BIN_IDX_PATH/ar_web_metadialog_split_01_text_document_dc\=5901018_sc\=5901018_tc\=6727468654
    0.016804300059397613 $BIN_IDX_PATH/ar_web_metadialog_split_02_text_document_dc\=6071497_sc\=6071497_tc\=6871975324
    0.016879464290858313 $BIN_IDX_PATH/ar_web_metadialog_split_03_text_document_dc\=6668426_sc\=6668426_tc\=6902713096
    0.01659494997302915 $BIN_IDX_PATH/ar_web_metadialog_split_04_text_document_dc\=6592093_sc\=6592093_tc\=6786363390
    0.0164650435274961 $BIN_IDX_PATH/ar_web_metadialog_split_05_text_document_dc\=5826549_sc\=5826549_tc\=6733239256
    0.016499530217440026 $BIN_IDX_PATH/ar_web_metadialog_split_06_text_document_dc\=6652064_sc\=6652064_tc\=6747342294
    0.01640319162867044 $BIN_IDX_PATH/ar_web_metadialog_split_07_text_document_dc\=6979539_sc\=6979539_tc\=6707945449
    0.016409739257453246 $BIN_IDX_PATH/ar_web_metadialog_split_08_text_document_dc\=7026762_sc\=7026762_tc\=6710623046
    0.01646025882577398 $BIN_IDX_PATH/ar_web_metadialog_split_09_text_document_dc\=7050626_sc\=7050626_tc\=6731282593
    0.01661685869702677 $BIN_IDX_PATH/ar_web_metadialog_split_10_text_document_dc\=6488044_sc\=6488044_tc\=6795322776
    0.016545150903887276 $BIN_IDX_PATH/ar_web_metadialog_split_11_text_document_dc\=6992450_sc\=6992450_tc\=6765998485
    0.0050213905319197736 $BIN_IDX_PATH/ar_web_metadialog_split_12_text_document_dc\=2365853_sc\=2365853_tc\=2053454872
    0.015735247568549708 $BIN_IDX_PATH/ar_web_oscar2301_split_00_text_document_dc\=4544790_sc\=4544790_tc\=6434795417
    0.01574412085283156 $BIN_IDX_PATH/ar_web_oscar2301_split_01_text_document_dc\=4488706_sc\=4488706_tc\=6438424071
    0.00029731799333217423 $BIN_IDX_PATH/ar_web_oscar2301_split_02_text_document_dc\=84865_sc\=84865_tc\=121585660
    0.0069552801081176775 $BIN_IDX_PATH/en_books_books_split_00_text_document_dc\=102105_sc\=102105_tc\=14473430615
    0.006956730749541952 $BIN_IDX_PATH/en_books_books_split_01_text_document_dc\=102718_sc\=102718_tc\=14476449294
    6.155679418718625e-$BIN_IDX_PATH/05\ en_books_books_split_02_text_document_dc=937_sc\=937_tc\=128095199
    0.006036300439292163 $BIN_IDX_PATH/en_code_github_split_00_text_document_dc\=6919454_sc\=6919454_tc\=15073321141
    0.00603404286297061 $BIN_IDX_PATH/en_code_github_split_01_text_document_dc\=6787019_sc\=6787019_tc\=15067683719
    0.006034939273533109 $BIN_IDX_PATH/en_code_github_split_02_text_document_dc\=6791613_sc\=6791613_tc\=15069922157
    0.006038185237451485 $BIN_IDX_PATH/en_code_github_split_03_text_document_dc\=6645201_sc\=6645201_tc\=15078027694
    0.0014699910076231546 $BIN_IDX_PATH/en_code_github_split_04_text_document_dc\=1650889_sc\=1650889_tc\=3670732886
    0.005915612471572103 $BIN_IDX_PATH/en_code_stackexchange_split_00_text_document_dc\=19981970_sc\=19981970_tc\=14771949711
    0.0028927789917171215 $BIN_IDX_PATH/en_code_stackexchange_split_01_text_document_dc\=9843118_sc\=9843118_tc\=7223594513
    0.0067482576692040955 $BIN_IDX_PATH/en_encyclopedia_m_wikipedia_split_00_text_document_dc\=14935020_sc\=14935020_tc\=14042632019
    0.004320136167349618 $BIN_IDX_PATH/en_encyclopedia_m_wikipedia_split_01_text_document_dc\=13560334_sc\=13560334_tc\=8989888271
    0.0005421180134044745 $BIN_IDX_PATH/en_encyclopedia_m_wikipedia_split_02_text_document_dc\=1338817_sc\=1338817_tc\=1128108046
    0.0027795664605154485 $BIN_IDX_PATH/en_encyclopedia_wikipedia_split_00_text_document_dc\=6630656_sc\=6630656_tc\=5784075074
    0.005785688222341386 $BIN_IDX_PATH/en_reasoning_open-web-math_split_00_text_document_dc\=5157493_sc\=5157493_tc\=12039595206
    0.001304467391914574 $BIN_IDX_PATH/en_reasoning_open-web-math_split_01_text_document_dc\=1157740_sc\=1157740_tc\=2714501500
    0.005031869085138972 $BIN_IDX_PATH/en_reasoning_peS2o_split_00_text_document_dc\=34104559_sc\=34104559_tc\=10470952562
    0.005553221141030264 $BIN_IDX_PATH/en_reasoning_peS2o_split_01_text_document_dc\=14452182_sc\=14452182_tc\=11555848165
    0.005889536456012716 $BIN_IDX_PATH/en_reasoning_peS2o_split_02_text_document_dc\=1721917_sc\=1721917_tc\=12255695806
    0.005889999889362526 $BIN_IDX_PATH/en_reasoning_peS2o_split_03_text_document_dc\=1720379_sc\=1720379_tc\=12256660177
    0.005889840417170668 $BIN_IDX_PATH/en_reasoning_peS2o_split_04_text_document_dc\=1719262_sc\=1719262_tc\=12256328327
    0.005890674513679858 $BIN_IDX_PATH/en_reasoning_peS2o_split_05_text_document_dc\=1721575_sc\=1721575_tc\=12258064021
    0.005890187475946767 $BIN_IDX_PATH/en_reasoning_peS2o_split_06_text_document_dc\=1722370_sc\=1722370_tc\=12257050531
    0.005889444213471727 $BIN_IDX_PATH/en_reasoning_peS2o_split_07_text_document_dc\=1719665_sc\=1719665_tc\=12255503856
    0.005890220890380748 $BIN_IDX_PATH/en_reasoning_peS2o_split_08_text_document_dc\=1721188_sc\=1721188_tc\=12257120064
    0.0058902085627021645 $BIN_IDX_PATH/en_reasoning_peS2o_split_09_text_document_dc\=1719879_sc\=1719879_tc\=12257094411
    0.0029098598137446995 $BIN_IDX_PATH/en_reasoning_peS2o_split_10_text_document_dc\=850041_sc\=850041_tc\=6055206039
    0.007477141022305014 $BIN_IDX_PATH/en_scientific_arxiv_split_00_text_document_dc\=805220_sc\=805220_tc\=15559385115
    0.007043231220947258 $BIN_IDX_PATH/en_scientific_arxiv_split_01_text_document_dc\=753086_sc\=753086_tc\=14656450466
    0.001970152089182906 $BIN_IDX_PATH/en_web_c4_split_00_text_document_dc\=22621766_sc\=22621766_tc\=12299228408
    0.001970619036671579 $BIN_IDX_PATH/en_web_c4_split_01_text_document_dc\=22603224_sc\=22603224_tc\=12302143459
    0.0019702782422508676 $BIN_IDX_PATH/en_web_c4_split_02_text_document_dc\=22618448_sc\=22618448_tc\=12300015954
    0.001970580483181941 $BIN_IDX_PATH/en_web_c4_split_03_text_document_dc\=22602978_sc\=22602978_tc\=12301902778
    0.0019704315944140357 $BIN_IDX_PATH/en_web_c4_split_04_text_document_dc\=22611696_sc\=22611696_tc\=12300973298
    0.0019702581015481695 $BIN_IDX_PATH/en_web_c4_split_05_text_document_dc\=22614260_sc\=22614260_tc\=12299890220
    0.00197032502876973 $BIN_IDX_PATH/en_web_c4_split_06_text_document_dc\=22629305_sc\=22629305_tc\=12300308032
    0.0019703468804085755 $BIN_IDX_PATH/en_web_c4_split_07_text_document_dc\=22608892_sc\=22608892_tc\=12300444447
    0.001970220727660984 $BIN_IDX_PATH/en_web_c4_split_08_text_document_dc\=22618605_sc\=22618605_tc\=12299656903
    0.0019704319013285248 $BIN_IDX_PATH/en_web_c4_split_09_text_document_dc\=22602542_sc\=22602542_tc\=12300975214
    0.0019703839622784783 $BIN_IDX_PATH/en_web_c4_split_10_text_document_dc\=22619301_sc\=22619301_tc\=12300675941
    0.0019703803608387823 $BIN_IDX_PATH/en_web_c4_split_11_text_document_dc\=22613813_sc\=22613813_tc\=12300653458
    0.0019702186039280527 $BIN_IDX_PATH/en_web_c4_split_12_text_document_dc\=22615189_sc\=22615189_tc\=12299643645
    0.0019701766577197937 $BIN_IDX_PATH/en_web_c4_split_13_text_document_dc\=22612514_sc\=22612514_tc\=12299381784
    0.0019705403747763616 $BIN_IDX_PATH/en_web_c4_split_14_text_document_dc\=22597746_sc\=22597746_tc\=12301652390
    0.00197035685256651 $BIN_IDX_PATH/en_web_c4_split_15_text_document_dc\=22616256_sc\=22616256_tc\=12300506701
    0.00023575994187555958 $BIN_IDX_PATH/en_web_c4_split_16_text_document_dc\=2706040_sc\=2706040_tc\=1471797731
    0.0019769003040735807 $BIN_IDX_PATH/en_web_cc_split_00_text_document_dc\=5634648_sc\=5634648_tc\=12341356037
    0.0019733792261559875 $BIN_IDX_PATH/en_web_cc_split_01_text_document_dc\=5560954_sc\=5560954_tc\=12319374718
    0.0019828855293842263 $BIN_IDX_PATH/en_web_cc_split_02_text_document_dc\=5537760_sc\=5537760_tc\=12378720489
    0.0019778372614680457 $BIN_IDX_PATH/en_web_cc_split_03_text_document_dc\=5598998_sc\=5598998_tc\=12347205257
    0.001973624036434125 $BIN_IDX_PATH/en_web_cc_split_04_text_document_dc\=5575777_sc\=5575777_tc\=12320903015
    0.0019745952072654266 $BIN_IDX_PATH/en_web_cc_split_05_text_document_dc\=5549841_sc\=5549841_tc\=12326965822
    0.001987617029030122 $BIN_IDX_PATH/en_web_cc_split_06_text_document_dc\=5589578_sc\=5589578_tc\=12408258206
    0.002032691941050815 $BIN_IDX_PATH/en_web_cc_split_07_text_document_dc\=5678451_sc\=5678451_tc\=12689651019
    0.002034129872114506 $BIN_IDX_PATH/en_web_cc_split_08_text_document_dc\=5649222_sc\=5649222_tc\=12698627708
    0.0020338646611533905 $BIN_IDX_PATH/en_web_cc_split_09_text_document_dc\=5663768_sc\=5663768_tc\=12696972054
    0.0020321804635695887 $BIN_IDX_PATH/en_web_cc_split_10_text_document_dc\=5694753_sc\=5694753_tc\=12686457977
    0.0020333377299830107 $BIN_IDX_PATH/en_web_cc_split_11_text_document_dc\=5662932_sc\=5662932_tc\=12693682538
    0.002034080642934347 $BIN_IDX_PATH/en_web_cc_split_12_text_document_dc\=5634501_sc\=5634501_tc\=12698320381
    0.0020342764399617266 $BIN_IDX_PATH/en_web_cc_split_13_text_document_dc\=5676090_sc\=5676090_tc\=12699542699
    0.0020012628274936823 $BIN_IDX_PATH/en_web_cc_split_14_text_document_dc\=5390653_sc\=5390653_tc\=12493445940
    0.0019793366409452235 $BIN_IDX_PATH/en_web_cc_split_15_text_document_dc\=5162978_sc\=5162978_tc\=12356565555
    0.0019797029076666773 $BIN_IDX_PATH/en_web_cc_split_16_text_document_dc\=5192753_sc\=5192753_tc\=12358852078
    0.0019855330495345113 $BIN_IDX_PATH/en_web_cc_split_17_text_document_dc\=5169213_sc\=5169213_tc\=12395248378
    0.0019783908328481147 $BIN_IDX_PATH/en_web_cc_split_18_text_document_dc\=5170636_sc\=5170636_tc\=12350661082
    0.001979497396539423 $BIN_IDX_PATH/en_web_cc_split_19_text_document_dc\=5161905_sc\=5161905_tc\=12357569117
    0.0019799469599493234 $BIN_IDX_PATH/en_web_cc_split_20_text_document_dc\=5193103_sc\=5193103_tc\=12360375643
    0.0019855626738308476 $BIN_IDX_PATH/en_web_cc_split_21_text_document_dc\=5164876_sc\=5164876_tc\=12395433316
    0.002015456608482131 $BIN_IDX_PATH/en_web_cc_split_22_text_document_dc\=5190741_sc\=5190741_tc\=12582054609
    0.0020425819210292523 $BIN_IDX_PATH/en_web_cc_split_23_text_document_dc\=5246670_sc\=5246670_tc\=12751392000
    0.002039219686577333 $BIN_IDX_PATH/en_web_cc_split_24_text_document_dc\=5267449_sc\=5267449_tc\=12730402306
    0.002039715142353341 $BIN_IDX_PATH/en_web_cc_split_25_text_document_dc\=5266480_sc\=5266480_tc\=12733495328
    0.002040216772781129 $BIN_IDX_PATH/en_web_cc_split_26_text_document_dc\=5249037_sc\=5249037_tc\=12736626897
    0.002042383843768182 $BIN_IDX_PATH/en_web_cc_split_27_text_document_dc\=5243484_sc\=5243484_tc\=12750155447
    0.0020415939711379816 $BIN_IDX_PATH/en_web_cc_split_28_text_document_dc\=5254413_sc\=5254413_tc\=12745224445
    0.002038568881771757 $BIN_IDX_PATH/en_web_cc_split_29_text_document_dc\=5265289_sc\=5265289_tc\=12726339474
    0.0020402493611409865 $BIN_IDX_PATH/en_web_cc_split_30_text_document_dc\=5257298_sc\=5257298_tc\=12736830339
    0.002026756650054765 $BIN_IDX_PATH/en_web_cc_split_31_text_document_dc\=5397981_sc\=5397981_tc\=12652598296
    0.0019724294722214 $BIN_IDX_PATH/en_web_cc_split_32_text_document_dc\=5769190_sc\=5769190_tc\=12313445612
    0.0019700129207620917 $BIN_IDX_PATH/en_web_cc_split_33_text_document_dc\=5779417_sc\=5779417_tc\=12298359610
    0.0019721946728659704 $BIN_IDX_PATH/en_web_cc_split_34_text_document_dc\=5767121_sc\=5767121_tc\=12311979811
    0.0019724471784322373 $BIN_IDX_PATH/en_web_cc_split_35_text_document_dc\=5768229_sc\=5768229_tc\=12313556148
    0.0019725414168785156 $BIN_IDX_PATH/en_web_cc_split_36_text_document_dc\=5758949_sc\=5758949_tc\=12314144458
    0.0019724027121933198 $BIN_IDX_PATH/en_web_cc_split_37_text_document_dc\=5798426_sc\=5798426_tc\=12313278555
    0.001969967009494152 $BIN_IDX_PATH/en_web_cc_split_38_text_document_dc\=5755542_sc\=5755542_tc\=12298072996
    0.0019948153783902766 $BIN_IDX_PATH/en_web_cc_split_39_text_document_dc\=5886477_sc\=5886477_tc\=12453195926
    0.0020256101105910695 $BIN_IDX_PATH/en_web_cc_split_40_text_document_dc\=5969898_sc\=5969898_tc\=12645440701
    0.0020266473225004273 $BIN_IDX_PATH/en_web_cc_split_41_text_document_dc\=5962779_sc\=5962779_tc\=12651915788
    0.002028474555851865 $BIN_IDX_PATH/en_web_cc_split_42_text_document_dc\=5918360_sc\=5918360_tc\=12663322806
    0.00202746597925656 $BIN_IDX_PATH/en_web_cc_split_43_text_document_dc\=5968099_sc\=5968099_tc\=12657026483
    0.0020256649786041326 $BIN_IDX_PATH/en_web_cc_split_44_text_document_dc\=5975921_sc\=5975921_tc\=12645783230
    0.0020257729908793104 $BIN_IDX_PATH/en_web_cc_split_45_text_document_dc\=5947770_sc\=5947770_tc\=12646457527
    0.002027443793151403 $BIN_IDX_PATH/en_web_cc_split_46_text_document_dc\=5944434_sc\=5944434_tc\=12656887980
    0.0020292973895924536 $BIN_IDX_PATH/en_web_cc_split_47_text_document_dc\=5930752_sc\=5930752_tc\=12668459577
    0.0020030020265246647 $BIN_IDX_PATH/en_web_cc_split_48_text_document_dc\=5968521_sc\=5968521_tc\=12504303379
    0.0019585004357353017 $BIN_IDX_PATH/en_web_cc_split_49_text_document_dc\=5951616_sc\=5951616_tc\=12226489685
    0.0019563583568143164 $BIN_IDX_PATH/en_web_cc_split_50_text_document_dc\=5943500_sc\=5943500_tc\=12213117155
    0.0019551300571568403 $BIN_IDX_PATH/en_web_cc_split_51_text_document_dc\=5938206_sc\=5938206_tc\=12205449149
    0.0019583868959558055 $BIN_IDX_PATH/en_web_cc_split_52_text_document_dc\=5975003_sc\=5975003_tc\=12225780881
    0.0019564491554475787 $BIN_IDX_PATH/en_web_cc_split_53_text_document_dc\=5944074_sc\=5944074_tc\=12213683991
    0.0019565456438525794 $BIN_IDX_PATH/en_web_cc_split_54_text_document_dc\=5944561_sc\=5944561_tc\=12214286347
    0.001955022788780873 $BIN_IDX_PATH/en_web_cc_split_55_text_document_dc\=5926865_sc\=5926865_tc\=12204779496
    0.002016636346930962 $BIN_IDX_PATH/en_web_cc_split_56_text_document_dc\=6307472_sc\=6307472_tc\=12589419458
    0.0020196858420860986 $BIN_IDX_PATH/en_web_cc_split_57_text_document_dc\=6237580_sc\=6237580_tc\=12608456789
    0.0020188455392084956 $BIN_IDX_PATH/en_web_cc_split_58_text_document_dc\=6288659_sc\=6288659_tc\=12603210962
    0.0020180140468270967 $BIN_IDX_PATH/en_web_cc_split_59_text_document_dc\=6274946_sc\=6274946_tc\=12598020137
    0.0020196188211563043 $BIN_IDX_PATH/en_web_cc_split_60_text_document_dc\=6318414_sc\=6318414_tc\=12608038392
    0.002019695537123957 $BIN_IDX_PATH/en_web_cc_split_61_text_document_dc\=6237973_sc\=6237973_tc\=12608517313
    0.00201872625695639 $BIN_IDX_PATH/en_web_cc_split_62_text_document_dc\=6289802_sc\=6289802_tc\=12602466309
    0.0020180455484918114 $BIN_IDX_PATH/en_web_cc_split_63_text_document_dc\=6277037_sc\=6277037_tc\=12598216795
    0.0019545210492670894 $BIN_IDX_PATH/en_web_cc_split_64_text_document_dc\=6100481_sc\=6100481_tc\=12201647246
    0.0019543694378344814 $BIN_IDX_PATH/en_web_cc_split_65_text_document_dc\=6045112_sc\=6045112_tc\=12200700769
    0.001955439781931823 $BIN_IDX_PATH/en_web_cc_split_66_text_document_dc\=6023112_sc\=6023112_tc\=12207382693
    0.001951895200547508 $BIN_IDX_PATH/en_web_cc_split_67_text_document_dc\=6044979_sc\=6044979_tc\=12185254647
    0.0019539653464652083 $BIN_IDX_PATH/en_web_cc_split_68_text_document_dc\=6062997_sc\=6062997_tc\=12198178115
    0.001952439830880585 $BIN_IDX_PATH/en_web_cc_split_69_text_document_dc\=6106624_sc\=6106624_tc\=12188654655
    0.0019554296250805657 $BIN_IDX_PATH/en_web_cc_split_70_text_document_dc\=5991541_sc\=5991541_tc\=12207319286
    0.001954485418993794 $BIN_IDX_PATH/en_web_cc_split_71_text_document_dc\=6048110_sc\=6048110_tc\=12201424814
    0.0019610380636790707 $BIN_IDX_PATH/en_web_cc_split_72_text_document_dc\=6142336_sc\=6142336_tc\=12242331541
    0.002011726869879515 $BIN_IDX_PATH/en_web_cc_split_73_text_document_dc\=6559407_sc\=6559407_tc\=12558770667
    0.0020149476045779094 $BIN_IDX_PATH/en_web_cc_split_74_text_document_dc\=6597968_sc\=6597968_tc\=12578877009
    0.002013058378504304 $BIN_IDX_PATH/en_web_cc_split_75_text_document_dc\=6593170_sc\=6593170_tc\=12567082984
    0.0020144741266665384 $BIN_IDX_PATH/en_web_cc_split_76_text_document_dc\=6564283_sc\=6564283_tc\=12575921190
    0.0020127704155043728 $BIN_IDX_PATH/en_web_cc_split_77_text_document_dc\=6553152_sc\=6553152_tc\=12565285294
    0.0020131168180024654 $BIN_IDX_PATH/en_web_cc_split_78_text_document_dc\=6597369_sc\=6597369_tc\=12567447809
    0.0020144571984743198 $BIN_IDX_PATH/en_web_cc_split_79_text_document_dc\=6596841_sc\=6596841_tc\=12575815511
    0.0020130278595746577 $BIN_IDX_PATH/en_web_cc_split_80_text_document_dc\=6574055_sc\=6574055_tc\=12566892461
    0.0013470619189075962 $BIN_IDX_PATH/en_web_cc_split_81_text_document_dc\=4396657_sc\=4396657_tc\=8409412812
)

# torchrun ${\DISTRIBUTED_ARGS[@]}\ pretrain_gpt.py\ \
python pretrain_gpt.py \
    ${GPT_MODEL_ARGS[@]} \
    ${LOGISTICS_ARGS[@]} \
    ${TRAINING_ARGS[@]} \
    ${MODEL_PARALLEL_ARGS[@]} \
    ${DATA_PATH[@]}
  
  
  
  
  
