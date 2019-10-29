void proc_1(unsigned char *in_00, unsigned char *in_01, unsigned char *in_1, unsigned char *out_0){
    for (int i = 0; i < 24; ++i){
        *(out_0 + i) = *(in_00 + i) + *(in_00 + i) + *(in_1 + i);
    }
}
