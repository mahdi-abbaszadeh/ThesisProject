void proc_3(unsigned char *in_0, unsigned char *out_00, unsigned char *out_01){
	for (int i = 0; i < 24; ++i){
		*(out_00 + i) = *(in_0 + i);
		*(out_01 + i) = !(*(in_0 + i));
	}
}