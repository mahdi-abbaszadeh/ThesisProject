void proc_4(unsigned char *in_0, unsigned char *out_0){
    for (int i = 0; i < 24; ++i){
        *(out_0 + i) = *(in_0 + i) - 5;
    }
}

