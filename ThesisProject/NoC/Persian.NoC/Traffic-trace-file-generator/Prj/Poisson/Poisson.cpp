// Poisson.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include <stdlib.h>
#include <time.h>
#include <math.h>


void main(int argc, char **argv)
{
	FILE *fp1;
	char filename[20];
	int distance, Gen_Per, Source_Num, Length, Node_Num;

	sscanf(argv[1], "%d", &Gen_Per);
	sscanf(argv[2], "%d", &Node_Num);
	sscanf(argv[3], "%d", &Length);
	for(Source_Num=0;Source_Num<Node_Num;Source_Num++)
	{
		for(long z=0;z<100000;z++);
		srand ((unsigned)time(NULL)+Source_Num*13);
		if (Gen_Per<10)
		{
			if (Source_Num<10)
				sprintf(filename, "00%d-0%d.txt", Gen_Per, Source_Num);
			else
				sprintf(filename, "00%d-%d.txt", Gen_Per, Source_Num);
		}
		else if (Gen_Per<100)
		{
			if (Source_Num<10)
				sprintf(filename, "0%d-0%d.txt", Gen_Per, Source_Num);
			else
				sprintf(filename, "0%d-%d.txt", Gen_Per, Source_Num);
		}
		else
		{
			if (Source_Num<10)
				sprintf(filename, "%d-0%d.txt", Gen_Per, Source_Num);
			else
				sprintf(filename, "%d-%d.txt", Gen_Per, Source_Num);
		}
		fp1 = fopen(filename , "w");

		for (int i=0; i<Length; i++) {	
			distance = log((double)(RAND_MAX+1)/((rand())+1))*Gen_Per + 1;
			fprintf(fp1, "%d\n", distance);
		}
		fclose(fp1);
	}
}
