clearscreen.
SET SHIP:CONTROL:PILOTMAINTHROTTLE TO 0.
print "Beginning Orbit Program...".

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
LOCK STEERING TO HEADING(90,80).
STAGE.
WAIT UNTIL SHIP:ALTITUDE > 1000.

// P-loop setup
print "Beginning PID Loop...".
SET g TO KERBIN:MU / KERBIN:RADIUS^2.
LOCK accvec TO SHIP:SENSORS:ACC - SHIP:SENSORS:GRAV.
LOCK gforce TO accvec:MAG / g.

set Kp to 0.01.
set Ki to 0.006.
set Kd to 0.006.
set pid to pidloop(Kp, Ki, Kd).
set pid:setpoint to 1.2.

SET thrott TO 1.
LOCK THROTTLE to thrott.

UNTIL SHIP:ALTITUDE > 12000 {
    SET thrott to thrott + pid:update(time:seconds, gforce).
    WAIT 0.001.
}

//-------------------------------------------------------------------
print "Full Throttle to 80k Apoapsis...".
LOCK STEERING TO HEADING(90,45).
LOCK THROTTLE to 1.
WAIT UNTIL SHIP:APOAPSIS > 80000.

LOCK THROTTLE TO 0.
UNLOCK STEERING.
wait 1.
SAS ON.
RCS ON.
wait 1.
SET SASMODE TO "PROGRADE".

WAIT UNTIL ETA:APOAPSIS < 12.

SAS OFF.

print "Circularizing...".
UNTIL SHIP:PERIAPSIS > 80000 {
	LOCK STEERING TO ship:prograde.
	LOCK THROTTLE to 1.
}

LOCK THROTTLE to 0.

print "Orbit Reached...".
