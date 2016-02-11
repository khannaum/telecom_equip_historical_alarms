/** DATEMATH - Demonstration program that shows how to
    do date mathematics by utilizing Unix procedures.
    This is missing some error checking, etc., but will
    show how to do "+n" and "-n" date math well enough.
    (C) Copyright 2005 by Dave Taylor. Free to redistribute
    if this copyright is left intact. Thanks.
***/

#include <stdio.h>
#include <time.h>

#define  ONEDAY         60*60*24

time_t time(time_t *tloc);
char *ctime(const time_t *clock);

main(int argc, char **argv)
{
        time_t  theTime;
        int     offset = 1;

        if (argc > 1) offset = atoi(argv[1]);

        theTime = time((time_t *) NULL);

        theTime += (long) (offset * ONEDAY);

        printf("Offset by %d, the date is: %s\n",
                offset, ctime(&theTime));
}
