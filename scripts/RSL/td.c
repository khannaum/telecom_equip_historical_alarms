#include <stdio.h>
#include <time.h>


int bree = 361535725;         // 16 Jun 1981, 4:35:25
int nat  = 96201950;          // 18 Jan 1973, 3:45:50

int difference = bree-nat;
write("There were %d seconds between Nat and Bree\n", difference);
// There were 265333775 seconds between Nat and Bree

int seconds =  difference                % 60;
int minutes = (difference / 60)          % 60;
int hours   = (difference / (60*60) )    % 24;
int days    = (difference / (60*60*24) ) % 7;
int weeks   =  difference / (60*60*24*7);

write("(%d weeks, %d days, %d:%d:%d)\n", weeks, days, hours, minutes, seconds);
// (438 weeks, 4 days, 23:49:35)

object bree = Calendar.dwim_time("16 Jun 1981, 4:35:25");
// Result: Second(Tue 16 Jun 1981 4:35:25 CEST)
object nat  = Calendar.dwim_time("18 Jan 1973, 3:45:50");
// Result: Second(Thu 18 Jan 1973 3:45:50 CET)
object difference = nat->range(bree);
// Result: Second(Thu 18 Jan 1973 3:45:50 CET - Tue 16 Jun 1981 4:35:26 CEST)

write("There were %d days between Nat and Bree\n", difference/Calendar.Day());
// There were 3071 days between Nat and Bree

int days=difference/Calendar.Day();
object left=difference->add(days,Calendar.Day)->range(difference->end());

// Calendar handles timezone differences, and since the range crosses from
// normal to daylight savings time, there is one day which has only 23 hours.
// by adding the number of days we effectively move the beginning of the range
// to the same day as the end, leaving us with a range that is less than a day
// long. when adding the days, the daylight savings switch will be taken into
// account.

write("Bree came %d days, %d:%d:%d after Nat\n", 
                   days, 
                   (left/Calendar.Hour())%24,
                   (left/Calendar.Minute())%60,
                   (left/Calendar.Second())%60,
                   );

// Bree came 3071 days, 0:49:36 after Nat

// the following is more accurate, taking into account that the days where
// daylight savings time is switched do not have 24, but 23 and 25 hours.
// thanks to mirar on the pike list for pointing this out and providing a
// correct solution.

array(int) breakdown_elapsed(object u, void|array on)
{  
  array res=({});
  if (!on) on=({Day,Hour,Minute,Second});
  foreach (on;;program|TimeRange p)
  {  
    if (u==u->end()) { res+=({0}); continue; }
    int x=u/p;
    u=u->add(x,p)->range(u->end());
    res+=({x});
  }
  return res;
}

write("Bree came %d days, %d:%d:%d after Nat\n",
      @breakdown_elapsed(difference));

// Bree came 3071 days, 0:49:36 after Nat

