void proc_2(unsigned char *in_0, unsigned char *out_0, unsigned char *out_1){
	for (int i = 0; i < 24; ++i){
		*(out_0 + i) = *(in_0 + i) * 2;
		*(out_1 + i) = *(in_0 + i) * 2;
	}
}