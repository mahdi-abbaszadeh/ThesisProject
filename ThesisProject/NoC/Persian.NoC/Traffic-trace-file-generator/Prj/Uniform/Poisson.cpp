// Poisson.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include <stdlib.h>
#include <time.h>
#include <math.h>

//#define Network_Size 16

void main(int argc, char **argv)
{
	FILE *fp1;
	char filename[20];
	int Source_Num, Num_Messages, distance,Network_Size;

	if (argv[1]==NULL || argv[2]==NULL) // || argv[3]==NULL )
	{
		//char** ch;
		//*ch=(char*)malloc(100);
		//argv=ch;
		argv[1]="16";
		argv[2]="10000";
	}
	sscanf(argv[1], "%d", &Network_Size);
	sscanf(argv[2], "%d", &Num_Messages);
	//sscanf(argv[3], "%d", &Network_Size);
for(long Source_Num=0 ; Source_Num<Network_Size ; Source_Num++)
{
	for(long z=0;z<=100000;z++);
	unsigned t=(unsigned)time(NULL);
	srand (t+Source_Num*7);
	//SLEEP(5);

	
	sprintf(filename, "%d.txt", Source_Num);
	fp1 = fopen(filename , "w");

	for (int i=0; i<Num_Messages; i++) {	
		distance = rand()% Network_Size;
		while (distance == Source_Num)
			distance = rand()% Network_Size;
		fprintf(fp1, "%d\n", distance);
	}
	fclose(fp1);
}
}
