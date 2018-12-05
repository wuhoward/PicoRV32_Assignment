#include "firmware.h"
#define K						5
#define MAX_INT                 2147483647
#define DATA_LENGTH             3073
#define NUM_CLASS				10
#define NUM_TEST_IMAGE			50
#define NUM_TRAIN_IMAGE			950
#define IMAGE_OFFSET 			0x00010000

void knn_mmap(void)
{
	int i, j;
	int distances[NUM_TRAIN_IMAGE];

	//just an example of single test image!
    for(i = 0; i < NUM_TRAIN_IMAGE; i++){
		//TODO: implement hardware & software versions of pairwise distance computation
		//e.g. distances[i] = hard_knn_pcpi(0, i + NUM_TEST_IMAGE);
	}
	
	//TODO: implement hardware version of label voting
	//you can use the algorithm we provided below, or any better algorithm you can think of
	int top_images[K][2];
	for(i = 0; i < K; i++){
		top_images[i][0] = MAX_INT; //distances of top-K closest images
		top_images[i][1] = 0;		//labels of top-K closest images
	}
		
	//iterate through all images, only keep the top-K closest images
	for(i = 0; i < NUM_TRAIN_IMAGE; i++){
        int insert_idx = -1;
		//get the index to insert, so that distances after this index are all larger
		for(j = 0; j < K; j++){
			if(distances[i] < top_images[j][0]){
				insert_idx = j;
				break;
			}
		}
		if(insert_idx >= 0){
			//insert new data, shift the rest
			for(j = K - 1; j > insert_idx; j--){
				top_images[j][0] = top_images[j-1][0];
				top_images[j][1] = top_images[j-1][1];
			}
			top_images[insert_idx][0] = distances[i];
			top_images[insert_idx][1] = i;
		}
	}

	int max_count = 0;
	int max_label = 0;
	int num_labels[NUM_CLASS] = {0};

	//find the label which gets the most votes
	for(i = 0; i < K; i++){
		int label = *(volatile uint32_t*)(IMAGE_OFFSET + (top_images[i][1] + NUM_TEST_IMAGE) * DATA_LENGTH * 4);
		num_labels[label]++;
		if(num_labels[label] > max_count){
			max_count = num_labels[label];
			max_label = label;
		}
	}

	print_str("\nThe result of soft_knn is:");
	print_dec(max_label);
	print_str("\n");
}

