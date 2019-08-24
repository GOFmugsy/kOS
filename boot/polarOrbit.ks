clearscreen.
SET SHIP:CONTROL:PILOTMAINTHROTTLE TO 0.
print "Beginning Polar 80k Orbit Program...".

from {local countdown is 5.} until countdown = 0 step {set countdown to countdown - 1.} do {
	print countdown.
	wait 1.
}.

// staging, throttle, steering, go
WHEN STAGE:LIQUIDFUEL < 0.1 THEN {
    STAGE.
    PRESERVE.
}
LOCK THROTTLE TO 1.
LOCK STEERING TO HEADING(0,80).
STAGE.
WAIT UNTIL SHIP:ALTITUDE > 1000.

RUN "0:/atmoBurn"(12000).

//-------------------------------------------------------------------

print "Full Throttle until 80k Apoapsis...".
LOCK STEERING TO HEADING(0,45).
LOCK THROTTLE to 1.
WAIT UNTIL SHIP:APOAPSIS > 80000.

LOCK THROTTLE TO 0.
RCS ON.
wait 1.
LOCK STEERING TO HEADING(0,0).

print "Coasting to 30s to Apoapsis...".
WAIT UNTIL ETA:APOAPSIS < 30.

RUN "0:/circularize"(20, 500).

print "Orbit Reached...".
